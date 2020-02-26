//
//  AirportBaseViewContrroller.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

protocol AirportViewController {
    func showAlert(title: String, message: String, actionText: String, action: AirportErrorAction)
    func display(airportList: [Airport])
}
