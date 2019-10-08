//
//  TransactionTypeUnderlinedTextField.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class TransactionTypeUnderlinedTextField: UnderlinedTextField {
    internal let TransactionTypePickerView = UIPickerView()
    private(set) var PickedDate : Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Field.addTarget(self, action: #selector(transactionTypeEditingDidBegin), for: .editingDidBegin)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func transactionTypeEditingDidBegin(sender: UITextField) {
        Underline.backgroundColor = HighlightColor
        let toolBar = createToolbar()
        sender.inputAccessoryView = toolBar
        sender.inputView = TransactionTypePickerView
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(transactionTypePickerCancel))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(transactionTypePickerDone))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolbar
    }
    
    @objc private func transactionTypePickerDone() {
        //self.Field.text = dateFormatter.string(from: DatePicker.date)
        //PickedDate = DatePicker.date
        self.endEditing(true)
    }
    
    @objc private func transactionTypePickerCancel() {
        self.endEditing(true)
    }
}
