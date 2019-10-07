//
//  Extensions.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func compareByYearAndDay(_ compareDate: Date) -> Bool {
        let calendar = Calendar.current
        
        let selfComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: self)
        let compareToComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: compareDate)
        
        let yearsAreEqual = selfComponents.year == compareToComponents.year
        if !yearsAreEqual { return false }
        let daysAreEqual = selfComponents.day == compareToComponents.day
        if !daysAreEqual { return false }
        return true
    }
    
    func toReadable() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let date = dateFormatter.string(from: self)
        return date
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

extension UIView {
    func setTopAnchor(to anchor: NSLayoutYAxisAnchor, withPadding padding: CGFloat = 0) {
        topAnchor.constraint(equalTo: anchor, constant: padding).isActive = true
    }
    
    func setBottomAnchor(to anchor: NSLayoutYAxisAnchor, withPadding padding: CGFloat = 0) {
        bottomAnchor.constraint(equalTo: anchor, constant: padding).isActive = true
    }
    
    func setLeadingAnchor(to anchor: NSLayoutXAxisAnchor, withPadding padding: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: anchor, constant: padding).isActive = true
    }
    
    func setTrailingAnchor(to anchor: NSLayoutXAxisAnchor, withPadding padding: CGFloat = 0) {
        trailingAnchor.constraint(equalTo: anchor, constant: padding).isActive = true
    }
    
    func setCenterXAnchor(to anchor: NSLayoutXAxisAnchor) {
        centerXAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    func setCenterYAnchor(to anchor: NSLayoutYAxisAnchor) {
        centerYAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    func setWidthAnchor(to width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeightAnchor(to height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
