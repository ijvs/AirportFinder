//
//  AppCoordinator.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {

    let window: UIWindow
    var distanceCoordinator: DistanceCoodinator

    lazy var airportListCoordinator: AirportCoordinator = {
        let coordinator = AirportCoordinatorImp(window: window)
        coordinator.delegate = self
        return coordinator
    }()

    let rootViewController: UINavigationController = {
        UINavigationController()
    }()

    init(window: UIWindow) {
        self.window = window
        distanceCoordinator = DistanceCoodinatorImp(window: window)
        distanceCoordinator.delegate = self
    }

    func start() {
        distanceCoordinator.start()
    }
}

// MARK: - DistanceCoodinatorDelegate
extension AppCoordinator: DistanceCoodinatorDelegate {
    func searchAirports(byRadius radius: Int) {
        airportListCoordinator.radius.update(with: radius)
        airportListCoordinator.start()
    }
}

// MARK: - AirportCoordinatorDelegate
extension AppCoordinator: AirportCoordinatorDelegate {
    func openRadiusPreferences() {
        distanceCoordinator.start()
    }
}
