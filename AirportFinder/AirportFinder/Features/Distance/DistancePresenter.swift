//
//  DistancePresenter.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

protocol DistancePresenter {
    var currentDistance: Int { get }
    func attach(view: DistanceViewControllerDelegate)
    func updateDistance(distance: Int)
    func search()
}

class DistancePresenterImp: DistancePresenter {

    var currentDistance: Int = 0

    func attach(view: DistanceViewControllerDelegate) {
        view.config(model: DistanceViewController.ViewModel(title: "AIRPORT",
                                                            subtitle: "finder",
                                                            sliderValue: 60,
                                                            sliderMaxValue: 100,
                                                            sliderMinValue: 1,
                                                            unitDescription: "KM search",
                                                            searchButtonTitle: "SEARCH"))
    }

    func updateDistance(distance: Int) {

    }

    func search() {

    }
}
