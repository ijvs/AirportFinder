//
//  AirportBaseViewContrroller.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

typealias AirportViewControllerState = ViewState<[AirportView.ViewModel], AirportViewErrorModel>

protocol AirportViewController {
    var identifier: String { get }
    func update(state: AirportViewControllerState)
}

struct AirportViewErrorModel {
    let title: String
    let message: String
    let actionText: String
    let action: AirportAction
}
