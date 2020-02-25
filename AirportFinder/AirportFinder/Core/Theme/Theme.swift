//
//  Theme.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    static var backgroundColor: UIColor = {
        return getDinamicColor(lightModeColor: .white, darkMode: .black)
    }()

    static var labelColor: UIColor = {
        return getDinamicColor(lightModeColor: .red, darkMode: .yellow)
    }()

    static var tintColor: UIColor = {
        return getDinamicColor(lightModeColor: .blue, darkMode: .blue)
    }()
}

// MARK: - Dinamic Color Fabric
extension Theme {
    private static func getDinamicColor(lightModeColor: UIColor, darkMode: UIColor) -> UIColor {
        UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return darkMode
            } else {
                return lightModeColor
            }
        }
    }
}
