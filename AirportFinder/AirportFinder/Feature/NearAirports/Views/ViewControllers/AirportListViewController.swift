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

    let loadingView = LoadingView()

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

    private func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        loadingView.configure()
        tableView.register(AirportViewCell.self, forCellReuseIdentifier: AirportViewCell.description())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Theme.backgroundColor
        view.backgroundColor = Theme.backgroundColor
    }

    private func showAlert(title: String, message: String) {

    }
}

// MARK: - AirportViewController
extension AirportListViewController: AirportViewControllerContract {

    var identifier: String {
        self.description
    }

    func showAlert(title: String, message: String, actionText: String, action: AirportAction) {

    }

    func update(state: ViewState<[AirportViewModel], AirportErrorViewModel>) {
        switch state {
        case .loading:
            loadingView.show()
        case .content(let content):
            loadingView.dismiss()
            if let content = content as? [AirportView.ViewModel] {
                airportList = content
                tableView.reloadData()
            }
        case .error(let errorModel):
            loadingView.dismiss()
            let alert = UIAlertController(title: errorModel.title,
                                          message: errorModel.message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: errorModel.actionText,
                                          style: .destructive,
                                          handler: {[weak self] (_) in
                                            self?.presenter.handle(action: errorModel.action)
            }))

            present(alert, animated: true, completion: nil)
        case .empty:
            loadingView.dismiss()
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
