//
//  Extensions.swift
//  CashTrack
//
//  Created by Jake Edwards on 7/30/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import Foundation

extension Double {
    public func round() -> String {
        let roundedAmount = String(format:"%.02f", self)
        return roundedAmount
    }
}

extension Int {
    public func getMonthString() -> String {
        let monthInteger = self-1
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        let monthString = months[monthInteger]
        return monthString
    }
}

extension Date {
    func equaltTo(_ rhs: Date) -> Bool {
        let lhsComponents = self.getComponents()
        let rhsComponents = rhs.getComponents()
        let equivalentTo = lhsComponents["year"] == rhsComponents["year"] && lhsComponents["month"] == rhsComponents["month"] && lhsComponents["day"] == rhsComponents["day"]
        return equivalentTo
    }
    
    func extendedEqualTo(_ rhs: Date) -> Bool {
        let lhsComponents = self.getComponents()
        let rhsComponents = rhs.getComponents()
        let equivalentTo = lhsComponents["year"] == rhsComponents["year"] && lhsComponents["month"] == rhsComponents["month"] && lhsComponents["day"] == rhsComponents["day"] && lhsComponents["hour"] == rhsComponents["hour"] && lhsComponents["minute"] == rhsComponents["minute"]
        return equivalentTo
    }
    
    func getComponents() -> [String: Int] {
        let calendar = Calendar.current
        let selfComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.hour, Calendar.Component.minute], from: self)
        let components = ["day" : selfComponents.day!, "month" : selfComponents.month!, "year" : selfComponents.year!, "hour" : selfComponents.hour!, "minute" : selfComponents.minute!]
        return components
    }
    
    func toReadable(withTimeStyle timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        //dateFormatter.timeStyle = dateFormatter.timeStyl
        let date = dateFormatter.string(from: self)
        return date
    }
}

extension Collection where Element: Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}

extension Collection {
    func sum<T: Numeric>(_ transform: (Element) throws -> T) rethrows -> T {
        return try map(transform).sum()
    }
}
