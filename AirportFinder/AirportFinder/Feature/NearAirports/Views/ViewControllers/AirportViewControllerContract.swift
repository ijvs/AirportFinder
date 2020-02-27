//
//  AirportBaseViewContrroller.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

protocol AirportViewControllerContract {
    var identifier: String { get }
    func update(state: ViewState<[AirportViewModel], AirportErrorViewModel>)
}
