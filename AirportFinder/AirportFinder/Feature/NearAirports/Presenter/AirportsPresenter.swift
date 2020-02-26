//
//  AirportsPresenter.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

protocol AirportsPresenter {
    func load()
    func attach(view: AirportViewController)
}

class AirportsPresenterImp: AirportsPresenter {

    private let locationUseCase: LocationUseCase
    private let airportUseCase: AirportUseCase
    private let coordinator: AirportCoordinator

    private var view: AirportViewController?

    var radius: Int

    init(locationUseCase: LocationUseCase = LocationUseCaseImp(),
         airportUseCase: AirportUseCase = AirportUseCaseImp(),
         coordinator: AirportCoordinator,
         radius: Int) {
        self.locationUseCase = locationUseCase
        self.airportUseCase = airportUseCase
        self.coordinator = coordinator
        self.radius = radius
    }

    func attach(view: AirportViewController) {
        self.view = view
    }
    func load() {
        let authorizationStatus = locationUseCase.getLocationAuthorizationStatus()

        switch authorizationStatus {
        case .authorized:
            locationUseCase.getCurrentLocation { (location) in
                guard let location = location else {
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.showAlert(title: "ERROR_TITLE".localized,
                                        message: "",
                                        actionText: "RETRY".localized,
                                        action: AirportErrorAction.load)
                    }
                    return
                }

                loadAirpots(radius: radius, location: location)
            }
        case .notDetermined:
            locationUseCase.requestLocationAuthorization()
        case .denied:
            DispatchQueue.main.async {[weak self] in
                self?.view?.showAlert(title: "LOCATION_DENIED_TITLE".localized,
                message: "LOCATION_DENIED_MESSAGE".localized,
                actionText: "LOCATION_DENIED_ACTION".localized,
                action: AirportErrorAction.goToAuthorizationSettings)
            }
        }
    }

    func loadAirpots(radius: Int, location: Location) {
        airportUseCase.getNearAirports(byRadius: radius, location: location) {[weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let airportList):
                    self.view?.display(airportList: airportList)
                case .failure(let error):
                    self.view?.showAlert(title: "ERROR_TITLE".localized,
                                         message: error.localizedDescription,
                                         actionText: "RETRY".localized,
                                         action: AirportErrorAction.load)
                }
            }
        }
    }

    func handle(action: AirportErrorAction) {
        switch action {
        case .load:
            load()
        case .goToAuthorizationSettings:
            coordinator.goToLocationSettings()
        }
    }
}

enum AirportErrorAction {
    case goToAuthorizationSettings
    case load
}
