//
//  DistanceCoordinator.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

protocol DistanceCoodinatorDelegate: class {
    func searchAirports(byRadius radius: Int)
}

protocol DistanceCoodinator: Coordinator {
    var delegate: DistanceCoodinatorDelegate? { get set }
    func searchAirports(byRadius radius: Int)
}

class DistanceCoodinatorImp {

    weak var delegate: DistanceCoodinatorDelegate?
    private let window: UIWindow
    private lazy var rootViewController: DistanceViewController = {
        let presenter = DistancePresenterImp(coordinator: self)
        return DistanceViewController(presenter: presenter)
    }()

    init(window: UIWindow) {
        self.window = window
    }
}

extension DistanceCoodinatorImp: DistanceCoodinator {

    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func searchAirports(byRadius radius: Int) {
        delegate?.searchAirports(byRadius: radius)
    }
}
