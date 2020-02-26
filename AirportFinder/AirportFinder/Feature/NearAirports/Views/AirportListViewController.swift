//
//  AirportListViewController.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

class AirportListViewController: UIViewController {

    var presenter: AirportPresenter
    private var airportList: [AirportView.ViewModel] = []
    private let tableView = UITableView()

    typealias AirportViewCell = ContainerTableViewCell<AirportView>

    init(presenter: AirportPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.attach(view: self)
        presenter.load()
    }

    func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        tableView.register(AirportViewCell.self, forCellReuseIdentifier: AirportViewCell.description())

        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - AirportViewController
extension AirportListViewController: AirportViewController {

    func showAlert(title: String, message: String, actionText: String, action: AirportAction) {

    }

    func update(state: ViewState<[AirportView.ViewModel], AirportViewErrorModel>) {

        switch state {
        case .loading:
            break
        case .content(let content):
            airportList = content
            tableView.reloadData()
        case .error:
            break //TODO: Use error model
        case .empty:
            airportList = []
            tableView.reloadData()
            // TODO: Show Empty placeholder
        }
    }
}

// MARK: - UITableViewDelegate
extension AirportListViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension AirportListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airportList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirportViewCell.description(),
                                                       for: indexPath) as? AirportViewCell else {
                                                        return UITableViewCell()
        }
        cell.view.configure(model: airportList[indexPath.row])
        return cell
    }
}
