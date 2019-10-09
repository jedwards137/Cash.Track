//
//  TransactionTypeUnderlinedTextField.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class TransactionTypeUnderlinedTextField: UnderlinedTextField, UIPickerViewDelegate, UIPickerViewDataSource {
    internal let TransactionTypePickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Field.addTarget(self, action: #selector(transactionTypeEditingDidBegin), for: .editingDidBegin)
        TransactionTypePickerView.dataSource = self
        TransactionTypePickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleForRow = TransactionType.allValues[row]
        return String(describing: titleForRow)
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
        let selectedRowIndex = TransactionTypePickerView.selectedRow(inComponent: 0)
        let selectedTransactionTypeText = String(describing: TransactionType.allValues[selectedRowIndex])
        self.Field.text = selectedTransactionTypeText
        self.endEditing(true)
    }
    
    @objc private func transactionTypePickerCancel() {
        self.endEditing(true)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
