//
//  ViewState.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

enum ViewState<Model, ErrorModel> {
    case loading
    case error(error: ErrorModel)
    case empty
    case content(content: Model)
}
