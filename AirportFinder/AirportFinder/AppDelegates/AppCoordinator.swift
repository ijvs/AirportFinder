//
//  AppCoordinator.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorDelegate {
    func goToAirporTabBar(radius: Int)
}

class AppCoordinator: Coordinator {

    let window: UIWindow
    var distanceCoordinator: DistanceCoodinator
    let airportListCoordinator: AirportCoordinator

    let rootViewController: UINavigationController = {
        UINavigationController()
    }()

    init(window: UIWindow) {
        self.window = window
        distanceCoordinator = DistanceCoodinatorImp(window: window)
        airportListCoordinator = AirportCoordinatorImp(window: window)

        distanceCoordinator.delegate = self
    }

    func start() {
        distanceCoordinator.start()
    }
}

extension AppCoordinator: DistanceCoodinatorDelegate {
    func searchAirports(byRadius radius: Int) {
        airportListCoordinator.start()
    }
}
