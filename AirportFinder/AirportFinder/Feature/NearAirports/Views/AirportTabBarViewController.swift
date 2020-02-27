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

    init(listPresenter: AirportPresenter, mapPresenter: AirportPresenter) {
        listViewController = AirportListViewController(presenter: listPresenter)
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
