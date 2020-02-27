//
//  AirportMapPreseneter.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/27/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

protocol AirportPresenter: class {
    var radius: Int { get }
    var coordinator: AirportCoordinator { get set }
    func attach(view: AirportViewControllerContract)
    func load()
    func handle(action: AirportAction)
}

// MARK: - AirportAction
enum AirportAction {
    case goToAuthorizationSettings
    case loadAirportList
}

// MARK: - AirportPresenterImp
class AirportPresenterImp<Model: AirportViewModel> {

    private let locationUseCase: LocationUseCase
    private let airportUseCase: AirportUseCase
    private var authorizationStatus: Bindable<LocationAuthorizationStatus>?
    private var view: AirportViewControllerContract?

    var coordinator: AirportCoordinator
    private var currentLocationBindable: Bindable<Location>?

    private var currentLocation: Location?
    var radius: Int = 0

    init(locationUseCase: LocationUseCase = LocationUseCaseImp(),
         airportUseCase: AirportUseCase = AirportUseCaseImp(),
         coordinator: AirportCoordinator) {
        self.locationUseCase = locationUseCase
        self.airportUseCase = airportUseCase
        self.coordinator = coordinator

        coordinator.radius.addObservation(for: coordinator.radius) {[weak self] (_, value) in
            self?.radius = value
            self?.loadAirportList()
        }
    }
}

// MARK: - AirportPresenter
extension AirportPresenterImp: AirportPresenter {

    func attach(view: AirportViewControllerContract) {
        self.view = view
    }

    func load() {
        guard authorizationStatus == nil else {
            return
        }

        let authorizationStatus = locationUseCase.getLocationAuthorizationStatus()
        authorizationStatus.addObservation(for: authorizationStatus) { [weak self] (_, status) in
            guard let self = self else { return }
            self.handle(authorizationStatusUpdates: status)
        }
        self.authorizationStatus = authorizationStatus
    }

    func handle(action: AirportAction) {
        switch action {
        case .loadAirportList:
            loadAirportList()
        case .goToAuthorizationSettings:
            coordinator.openAppLocationSettings()
        }
    }
}

// MARK: - Private Methods
extension AirportPresenterImp {

    private func handle(authorizationStatusUpdates status: LocationAuthorizationStatus) {
        switch status {
        case .authorized:
            guard let currentLocation = currentLocationBindable else {
                self.currentLocationBindable = locationUseCase.getCurrentLocation()
                handle(authorizationStatusUpdates: status)
                return
            }

            currentLocation.addObservation(for: currentLocation, handler: { [weak self] (_, location) in
                guard let self = self else { return }
                self.currentLocation = location
                self.loadAirportList()
            })
        case .notDetermined:
            locationUseCase.requestLocationAuthorization()

        case .denied:
            let errorViewModel = AirportErrorViewModel(title: "LOCATION_DENIED_TITLE".localized,
                                                       message: "LOCATION_DENIED_MESSAGE".localized,
                                                       actionText: "LOCATION_DENIED_ACTION".localized,
                                                       action: AirportAction.goToAuthorizationSettings)
            sendViewStateUpdate(state: .error(error: errorViewModel))
        }
    }

    private func loadAirportList() {
        guard let currentLocation = currentLocation, radius > 0 else {
            return
        }
        loadAirportList(radius: radius, location: currentLocation)
    }

    private func loadAirportList(radius: Int, location: Location) {
        sendViewStateUpdate(state: .loading)

        airportUseCase.getNearAirports(byRadius: radius, location: location) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let airportList):
                let viewModelList = airportList.map { Model(entity: $0) }
                self.sendViewStateUpdate(state: .content(content: viewModelList))
            case .failure(let error):
                let errorViewModel = AirportErrorViewModel(title: "ERROR_TITLE".localized,
                                                           message: error.localizedDescription,
                                                           actionText: "RETRY".localized,
                                                           action: AirportAction.loadAirportList)
                self.sendViewStateUpdate(state: .error(error: errorViewModel))
            }
        }
    }

    private func sendViewStateUpdate(state: ViewState<[AirportViewModel], AirportErrorViewModel>) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.update(state: state)
        }
    }
}
