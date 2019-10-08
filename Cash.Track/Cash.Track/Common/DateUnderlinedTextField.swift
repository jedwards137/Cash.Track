//
//  DateUnderlinedTextField.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class DateUnderlinedTextField: UnderlinedTextField {
    internal let DatePicker = UIDatePicker()
    private(set) var PickedDate : Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Field.addTarget(self, action: #selector(dateEditingDidBegin), for: .editingDidBegin)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dateEditingDidBegin(sender: UITextField) {
        Underline.backgroundColor = HighlightColor
        DatePicker.datePickerMode = .date
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.Field.text = dateFormatter.string(from: DatePicker.date)
        PickedDate = DatePicker.date
        self.endEditing(true)
    }
    
    @objc private func datePickerCancel() {
        self.endEditing(true)
    }
}
