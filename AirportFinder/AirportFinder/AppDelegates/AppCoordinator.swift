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
    let distanceCoordinator: DistanceCoodinator

    let rootViewController: UINavigationController = {
        UINavigationController()
    }()

    init(window: UIWindow) {
        self.window = window
        distanceCoordinator = DistanceCoodinator(window: window)
    }

    func start() {
        distanceCoordinator.start()
    }
}
