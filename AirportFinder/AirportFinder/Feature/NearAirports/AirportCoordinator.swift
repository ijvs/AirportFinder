//
//  AirportCoordinator.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

protocol AirportCoordinator: class, Coordinator {
    var radius: Bindable<Int> { get set }
    func openRadiusPreferences()
    func openAppLocationSettings()
}

protocol AirportCoordinatorDelegate: class {
    func openRadiusPreferences()
}

// MARK: - AirportCoordinator
class AirportCoordinatorImp: AirportCoordinator {

    weak var delegate: AirportCoordinatorDelegate?
    let window: UIWindow
    var radius: Bindable<Int> = Bindable<Int>()

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

    func openRadiusPreferences() {
        delegate?.openRadiusPreferences()
    }

    func openAppLocationSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
}
