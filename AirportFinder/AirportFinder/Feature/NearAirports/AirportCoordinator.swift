//
//  AirportCoordinator.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

protocol AirportCoordinator: Coordinator {
    var radius: Int { get set }
    func goToLocationSettings()
}

class AirportCoordinatorImp: AirportCoordinator {

    let window: UIWindow
    var radius: Int = 0

    private lazy var tabBarController: AirportTabBarViewController = {
        AirportTabBarViewController(coordinator: self)
    }()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func goToLocationSettings() {

    }
}
