//
//  AirportTabBarViewController.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

class AirportTabBarViewController: UITabBarController {

    private var listViewController: AirportListViewController
    private var mapViewController: AirportMapViewController

    init(coordinator: AirportCoordinator) {

        let listPresenter = AirportMapPresenterImp<AirportView.ViewModel>(coordinator: coordinator)
        listViewController = AirportListViewController(presenter: listPresenter)

        let mapPresenter = AirportMapPresenterImp<AirportAnnotation.ViewModel>(coordinator: coordinator)
        mapViewController = AirportMapViewController(presenter: mapPresenter)

        super.init(nibName: nil, bundle: nil)

        mapViewController.tabBarItem = UITabBarItem(title: "Map",
                                                    image: UIImage(systemName: "map"),
                                                    tag: 0)
        listViewController.tabBarItem = UITabBarItem(title: "List",
                                                     image: UIImage(systemName: "list.dash"),
                                                     tag: 1)

        setViewControllers([mapViewController, listViewController], animated: false)
    }

    func updateSearchRadius(radius: Int) {

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
