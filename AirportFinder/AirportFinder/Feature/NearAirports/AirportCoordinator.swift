//
//  AirportCoordinator.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

protocol AirportCoordinator {
    func goToLocationSettings()
}

class AirportCoordinatorImp: Coordinator, AirportCoordinator {

    let window: UIWindow

    private var airportListViewController: AirportListViewController?

    init(window: UIWindow) {
        self.window = window

        let presenter = AirportPresenterImp(coordinator: self, radius: 100)
        airportListViewController = AirportListViewController(presenter: presenter)
    }

    func start() {
        window.rootViewController = airportListViewController
        window.makeKeyAndVisible()
    }

    func goToLocationSettings() {
    }
}
