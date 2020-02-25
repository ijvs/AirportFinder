//
//  DistanceViewController+ViewModel.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

extension DistanceViewController {
    struct ViewModel {
        let title: String
        let subtitle: String
        let sliderValue: Float
        let sliderMaxValue: Float
        let sliderMinValue: Float
        let unitDescription: String
        let searchButtonTitle: String
    }
}
