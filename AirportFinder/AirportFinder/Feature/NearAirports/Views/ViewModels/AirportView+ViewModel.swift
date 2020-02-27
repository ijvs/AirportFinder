//
//  AirportView+ViewModel.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/27/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

extension AirportView {
    struct ViewModel: AirportViewModel {
        let title: String
        let accessoryText: String
        let description: String

        init(entity: AirportEntity) {
            title = entity.name
            accessoryText = entity.code
            description = entity.city
        }
    }
}
