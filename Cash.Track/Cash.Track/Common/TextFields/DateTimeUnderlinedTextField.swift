//
//  TimeUnderlinedTextField.swift
//  Cash.Track
//
//  Created by Jake Edwards on 11/10/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import Foundation
import UIKit

class DateTimeUnderlinedTextField: UnderlinedTextField {
    private(set) var DatePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func textFieldEditingDidBegin(sender: UITextField) {
        Underline.backgroundColor = HighlightColor
        DatePicker.datePickerMode = .dateAndTime
        let toolBar = createToolbar()
        sender.inputAccessoryView = toolBar
        sender.inputView = DatePicker
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(datePickerCancel))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerDone))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolbar
    }
    
    @objc private func datePickerDone() {
        let selectedDate = DatePicker.date
        self.Field.text = selectedDate.toReadable(withTimeStyle: .short)
        self.endEditing(true)
    }
    
    @objc private func datePickerCancel() {
        self.endEditing(true)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
