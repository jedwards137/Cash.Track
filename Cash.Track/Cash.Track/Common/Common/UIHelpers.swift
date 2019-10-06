//
//  UIHelpers.swift
//  Cash.Track
//
//  Created by Jake Edwards on 8/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import Foundation
import UIKit

public class UIHelpers {
    public static func getPosNegColorFor(total: Double) -> UIColor {
        let totalIsNegative = total < 0
        if totalIsNegative {
            return UIColor(r: 229, g: 126, b: 100)
        }
        return UIColor(r: 129, g: 232, b: 141)
    }
}
