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

    private var presenter: AirportPresenter

    private lazy var listViewController: AirportListViewController = {
        return AirportListViewController(presenter: presenter)
    }()

    private lazy var mapViewController: AirportMapViewController = {
        return AirportMapViewController(presenter: presenter)
    }()

    private lazy var tabBarController: AirportTabBarViewController = {
        AirportTabBarViewController()
    }()

    init(window: UIWindow) {
        self.window = window

        presenter = AirportPresenterImp()
        presenter.coordinator = self
        presenter.radius = radius
    }

    func start() {
        presenter.radius = radius
        tabBarController.configure(withControllers: [mapViewController, listViewController])
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func goToLocationSettings() {

    }
}
