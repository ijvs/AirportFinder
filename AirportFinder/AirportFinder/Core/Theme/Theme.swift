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
        return getDinamicColor(lightModeColor: UIColor(white: 240/255, alpha: 1),
                               darkMode: UIColor(white: 22/255, alpha: 1.0))
    }()

    static var labelColor: UIColor = {
        return getDinamicColor(lightModeColor: UIColor(white: 22/255, alpha: 1.0),
                               darkMode: UIColor(white: 240/255, alpha: 1))
    }()

    static var secondaryLabelColor: UIColor = {
        return .gray
    }()

    static var tintColor: UIColor = {
        return UIColor(red: 247/255, green: 181/255, blue: 0/255, alpha: 1)
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
