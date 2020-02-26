//
//  AirportView.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

class AirportView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = Theme.labelColor
        return label
    }()

    private let accessoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = Theme.secondaryLabelColor
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = Theme.secondaryLabelColor
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: LayoutConstants.horizontalMargin),
            titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: LayoutConstants.verticalMargin)
        ])

        accessoryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(accessoryLabel)
        NSLayoutConstraint.activate([
            accessoryLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                                constant: LayoutConstants.horizontalSpacing),
            accessoryLabel.lastBaselineAnchor.constraint(equalTo: titleLabel.lastBaselineAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: accessoryLabel.trailingAnchor,
                                                  constant: LayoutConstants.horizontalMargin)
        ])

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: LayoutConstants.horizontalMargin),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                            constant: LayoutConstants.verticalSpacing),
            bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                                constant: LayoutConstants.verticalMargin)
        ])
    }

    func configure(model: ViewModel) {
        titleLabel.text = model.title
        accessoryLabel.text = model.accessoryText
        descriptionLabel.text = model.description
    }
}

// MARK: - Layout Constants
extension AirportView {
    struct LayoutConstants {
        static let horizontalMargin: CGFloat = 16
        static let verticalMargin: CGFloat = 16
        static let horizontalSpacing: CGFloat = 8
        static let verticalSpacing: CGFloat = 8
    }

    struct ViewModel {
        let title: String
        let accessoryText: String
        let description: String
    }
}
