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

    private weak var listPresenter: AirportPresenter?
    private weak var mapPresenter: AirportPresenter?
    private var tabBarController: AirportTabBarViewController

    init(window: UIWindow) {
        self.window = window

        let listPresenter = AirportMapPresenterImp<AirportView.ViewModel>()
        let mapPresenter = AirportMapPresenterImp<AirportAnnotation.ViewModel>()

        tabBarController = AirportTabBarViewController(listPresenter: listPresenter, mapPresenter: mapPresenter)
        listPresenter.coordinator = self
        listPresenter.radius = radius
        self.listPresenter = listPresenter

        mapPresenter.coordinator = self
        mapPresenter.radius = radius
        self.mapPresenter = mapPresenter
    }

    func start() {
        listPresenter?.radius = radius
        mapPresenter?.radius = radius
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func goToLocationSettings() {

    }
}
