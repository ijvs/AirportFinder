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
    private weak var coordinator: AirportCoordinator?

    private lazy var changeRadiusButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapChangeRaidusButton), for: .touchUpInside)
        button.layer.cornerRadius = LayoutConstants.buttonHeight/2
        button.backgroundColor = Theme.tintColor
        button.setTitle("RADIUS".localized, for: .normal)
        return button
    }()

    init(coordinator: AirportCoordinator) {
        self.coordinator = coordinator
        let listPresenter = AirportPresenterImp<AirportView.ViewModel>(coordinator: coordinator)
        listViewController = AirportListViewController(presenter: listPresenter)

        let mapPresenter = AirportPresenterImp<AirportAnnotation.ViewModel>(coordinator: coordinator)
        mapViewController = AirportMapViewController(presenter: mapPresenter)

        super.init(nibName: nil, bundle: nil)

        mapViewController.tabBarItem = UITabBarItem(title: "Map",
                                                    image: UIImage(systemName: "map"),
                                                    tag: 0)
        listViewController.tabBarItem = UITabBarItem(title: "List",
                                                     image: UIImage(systemName: "list.dash"),
                                                     tag: 1)

        setViewControllers([mapViewController, listViewController], animated: false)

        changeRadiusButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeRadiusButton)
        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: changeRadiusButton.bottomAnchor,
                                                       constant: LayoutConstants.buttonMargin),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: changeRadiusButton.trailingAnchor,
                                                        constant: LayoutConstants.buttonMargin),
            changeRadiusButton.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth),
            changeRadiusButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight)
        ])

        coordinator.radius.addObservation(for: coordinator.radius) {[weak self] (_, radius) in
            self?.changeRadiusButton.setTitle("RADIUS".localized + ": \(radius)", for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTapChangeRaidusButton() {
        coordinator?.openRadiusPreferences()
    }
}

extension AirportTabBarViewController {
    struct LayoutConstants {
        static let buttonWidth: CGFloat = 160
        static let buttonHeight: CGFloat = 40
        static let buttonMargin: CGFloat = 16
    }
}
