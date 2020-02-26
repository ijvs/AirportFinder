//
//  DistanceCoordinator.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

class DistanceCoodinator: Coordinator {

    let window: UIWindow
    let rootViewController = DistanceViewController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
