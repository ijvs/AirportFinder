//
//  AirportsPresenter.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

// MARK: - AirportErrorAction
enum AirportAction {
    case goToAuthorizationSettings
    case load
}

// MARK: - AirportPresenter
protocol AirportPresenter {
    var radius: Int {get set }
    var coordinator: AirportCoordinator? { get set }
    func attach(view: AirportViewController)
    func load()
    func handle(action: AirportAction)
}

// MARK: - AirportPresenterImp
class AirportPresenterImp {

    private let locationUseCase: LocationUseCase
    private let airportUseCase: AirportUseCase
    private var authorizationStatus: Bindable<LocationAuthorizationStatus>?
    private var currentLocation: Bindable<Location>?
    private var views: [String: AirportViewController] = [String: AirportViewController]()

    var coordinator: AirportCoordinator?
    var radius: Int = 0

    init(locationUseCase: LocationUseCase = LocationUseCaseImp(),
         airportUseCase: AirportUseCase = AirportUseCaseImp()) {
        self.locationUseCase = locationUseCase
        self.airportUseCase = airportUseCase
    }
}

// MARK: - AirportPresenter
extension AirportPresenterImp: AirportPresenter {
    func attach(view: AirportViewController) {
        self.views[view.identifier] = view
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
        case .load:
            load()
        case .goToAuthorizationSettings:
            coordinator?.goToLocationSettings()
        }
    }
}

// MARK: - Private Methods
extension AirportPresenterImp {
    private func handle(authorizationStatusUpdates status: LocationAuthorizationStatus) {
        switch status {
        case .authorized:

            guard let currentLocation = currentLocation else {
                self.currentLocation = locationUseCase.getCurrentLocation()
                handle(authorizationStatusUpdates: status)
                return
            }

            currentLocation.addObservation(for: currentLocation, handler: { [weak self] (_, location) in
                guard let self = self else { return }
                print("🛩 airports updated")
                self.loadAirportList(radius: self.radius, location: location)
            })

        case .notDetermined:
            locationUseCase.requestLocationAuthorization()

        case .denied:
            let errorViewModel = AirportViewErrorModel(title: "LOCATION_DENIED_TITLE".localized,
                                                       message: "LOCATION_DENIED_MESSAGE".localized,
                                                       actionText: "LOCATION_DENIED_ACTION".localized,
                                                       action: AirportAction.goToAuthorizationSettings)
            sendViewStateUpdate(state: .error(error: errorViewModel))
        }
    }

    private func loadAirportList(radius: Int, location: Location) {
        print("🥵 Loading Airports")
        sendViewStateUpdate(state: .loading)

        airportUseCase.getNearAirports(byRadius: radius, location: location) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let airportList):
                let viewModelList = airportList.map { (airport) -> AirportView.ViewModel in
                    AirportView.ViewModel(title: airport.name,
                                          accessoryText: airport.code,
                                          description: airport.countryCode)
                }
                print("🚀 updating ui")
                self.sendViewStateUpdate(state: .content(content: viewModelList))
            case .failure(let error):
                let errorViewModel = AirportViewErrorModel(title: "ERROR_TITLE".localized,
                                                           message: error.localizedDescription,
                                                           actionText: "RETRY".localized,
                                                           action: AirportAction.load)
                self.sendViewStateUpdate(state: .error(error: errorViewModel))
            }
        }
    }

    private func sendViewStateUpdate(state: AirportViewControllerState) {
        DispatchQueue.main.async { [weak self] in
            print(state)
            self?.views.forEach({ $1.update(state: state) })
        }
    }
}
