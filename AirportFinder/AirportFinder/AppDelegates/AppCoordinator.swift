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
        AirportCoordinatorImp(window: window)
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

extension AppCoordinator: DistanceCoodinatorDelegate {
    func searchAirports(byRadius radius: Int) {
        airportListCoordinator.radius = radius
        airportListCoordinator.start()
    }
}
