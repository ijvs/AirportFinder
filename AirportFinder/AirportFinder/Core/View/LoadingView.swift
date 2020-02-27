//
//  LoadingView.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {

    private let blurredEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    private let activityIndicator = UIActivityIndicatorView()

    func configure() {
        alpha = 0
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurredEffectView)
        NSLayoutConstraint.activate([
            blurredEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurredEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurredEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurredEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

    }

    func show() {
        superview?.endEditing(true)
        superview?.bringSubviewToFront(self)
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.alpha = 1
        })
    }

    func dismiss() {
        superview?.sendSubviewToBack(self)
        activityIndicator.stopAnimating()

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.alpha = 0
        })
    }
}
