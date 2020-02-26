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

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(withControllers controllerList: [UIViewController]) {
        viewControllers = controllerList
    }
}
