//
//  DistanceViewController.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

protocol DistanceViewControllerDelegate {
    func config(model: DistanceViewController.ViewModel)
}

class DistanceViewController: UIViewController {

    let presenter: DistancePresenter

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.labelColor
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.labelColor
        return label
    }()

    let counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.labelColor
        return label
    }()

    let counterSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = Theme.tintColor
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    let counterUnitsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.labelColor
        return label
    }()

    let searchButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = LayoutConstants.searchButtonCornerRadius
        button.backgroundColor = Theme.tintColor
        button.setTitleColor(Theme.labelColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(presenter: DistancePresenter = DistancePresenterImp()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupView()

        presenter.attach(view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        configLayout()
        counterSlider.addTarget(self, action: #selector(sliderDidChange), for: .valueChanged)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
    }
}

// MARK: - Layout
extension DistanceViewController {
    struct LayoutConstants {
        static let horizontalMargin: CGFloat = 30
        static let verticalMargin: CGFloat = 50
        static let verticalSpacing: CGFloat = 20
        static let searchButtonHeight: CGFloat = 50
        static let searchButtonCornerRadius: CGFloat = 8
    }

    private func configLayout() {
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(counterSlider)
        NSLayoutConstraint.activate([
            counterSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            counterSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: LayoutConstants.horizontalMargin),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: counterSlider.trailingAnchor,
                                           constant: LayoutConstants.horizontalMargin)
        ])
        view.addSubview(counterLabel)
        NSLayoutConstraint.activate([
            counterSlider.topAnchor.constraint(equalTo: counterLabel.bottomAnchor,
                                               constant: LayoutConstants.verticalSpacing),
            counterLabel.leadingAnchor.constraint(equalTo: counterSlider.leadingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: counterSlider.trailingAnchor)
        ])
        view.addSubview(counterUnitsLabel)
        NSLayoutConstraint.activate([
            counterUnitsLabel.leadingAnchor.constraint(equalTo: counterSlider.leadingAnchor),
            counterUnitsLabel.trailingAnchor.constraint(equalTo: counterSlider.trailingAnchor),
            counterUnitsLabel.topAnchor.constraint(equalTo: counterSlider.bottomAnchor,
                                                   constant: LayoutConstants.verticalSpacing)
        ])
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: LayoutConstants.verticalMargin),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: LayoutConstants.horizontalMargin),
            view.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                           constant: LayoutConstants.horizontalMargin)

        ])
        view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                            constant: LayoutConstants.verticalSpacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: LayoutConstants.horizontalMargin),
            view.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor,
                                           constant: LayoutConstants.horizontalMargin)

        ])
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: searchButton.bottomAnchor,
                                                 constant: LayoutConstants.verticalMargin),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: LayoutConstants.horizontalMargin),
            view.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor,
                                           constant: LayoutConstants.horizontalMargin),
            searchButton.heightAnchor.constraint(equalToConstant: LayoutConstants.searchButtonHeight)
        ])
    }
}

// MARK: -
extension DistanceViewController {

    @objc func sliderDidChange() {
        let value = Int(counterSlider.value)
        counterLabel.text = "\(value)"
    }

    @objc func didTapSearchButton() {

    }
}

// MARK: - DistanceViewControllerDelegate
extension DistanceViewController: DistanceViewControllerDelegate {
    public func config(model: ViewModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        counterSlider.maximumValue = model.sliderMaxValue
        counterSlider.minimumValue = model.sliderMinValue
        counterSlider.value = model.sliderValue
        counterUnitsLabel.text = model.unitDescription
        searchButton.setTitle(model.searchButtonTitle, for: .normal)
        sliderDidChange()
        
        view.setNeedsLayout()
       }
}
