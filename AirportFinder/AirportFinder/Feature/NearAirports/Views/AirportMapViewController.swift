//
//  AirportMapViewController.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

class AirportMapViewController: UIViewController {

    var presenter: AirportPresenter


    init(presenter: AirportPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .yellow
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupView()
        presenter.attach(view: self)
        presenter.load()
    }

    private func setupView() {
        
    }
}

extension AirportMapViewController: AirportViewController {
    var identifier: String {
        self.description
    }

    func update(state: AirportViewControllerState) {
        
    }
}
