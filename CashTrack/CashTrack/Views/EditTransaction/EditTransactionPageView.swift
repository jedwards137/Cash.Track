//
//  EditTransactionPageView.swift
//  CashTrack
//
//  Created by Jake Edwards on 9/3/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class EditTransactionPageView: UIViewBase {
    private let HighlightColor: UIColor = .blue
    private let UnderlineColor: UIColor = .black
    private(set) var NameField: UnderlinedTextField
    private(set) var AmountField: DollarUnderlinedTextField
    private(set) var DateField: DateUnderlinedTextField
    private(set) var UpdateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) var DeleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init() {
        self.NameField = UnderlinedTextField(title: "Name", highlightColor: HighlightColor, textAlignment: .left, placeholder: "Coffee", keyboardType: .default, underlineColor: UnderlineColor)
        self.AmountField = DollarUnderlinedTextField(title: "Amount", highlightColor: HighlightColor, textAlignment: .left, placeholder: "10", keyboardType: .numberPad, underlineColor: UnderlineColor)
        self.DateField = DateUnderlinedTextField(title: "Date", highlightColor: HighlightColor, textAlignment: .left, placeholder: "Jan 1, 2000 at 11:00 AM", underlineColor: UnderlineColor)
        
        super.init()
        self.backgroundColor = .white
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponderHandler))
            self.addGestureRecognizer(tapRecognizer)
    }
    
    public func setInfoFor(_ transaction: Transaction) {
        self.NameField.Field.text = "\(transaction.Name)"
        self.AmountField.Field.text = "\(transaction.Amount)"
        self.DateField.Field.text = transaction.Date.toReadable(withTimeStyle: .short)
    }
        
    @objc private func resignFirstResponderHandler() {
        self.endEditing(true)
    }
        
    internal override func addSubviews() {
        let subviews = [self.NameField, self.AmountField, self.DateField, self.UpdateButton, self.DeleteButton]
        subviews.forEach { subview in self.addSubview(subview) }
    }
    
    internal override func anchorSubviews() {
        self.NameField.setTopAnchor(to: self.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.NameField.setHeightAnchor(to: UIValues.FieldHeight)
        self.NameField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.NameField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        
        self.AmountField.setTopAnchor(to: self.NameField.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.AmountField.setHeightAnchor(to: UIValues.FieldHeight)
        self.AmountField.setLeadingAnchor(to: self.NameField.leadingAnchor)
        self.AmountField.setTrailingAnchor(to: self.centerXAnchor, withPadding: -UIValues.EdgePadding)
        
        self.DateField.setTopAnchor(to: self.AmountField.topAnchor)
        self.DateField.setHeightAnchor(to: UIValues.FieldHeight)
        self.DateField.setLeadingAnchor(to: self.centerXAnchor, withPadding: UIValues.EdgePadding)
        self.DateField.setTrailingAnchor(to: self.NameField.trailingAnchor)
        
        self.UpdateButton.setTopAnchor(to: self.AmountField.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.UpdateButton.setHeightAnchor(to: UIValues.ButtonHeight)
        self.UpdateButton.setLeadingAnchor(to: self.NameField.leadingAnchor)
        self.UpdateButton.setTrailingAnchor(to: self.centerXAnchor, withPadding: -UIValues.EdgePadding)
        
        self.DeleteButton.setTopAnchor(to: self.UpdateButton.topAnchor)
        self.DeleteButton.setHeightAnchor(to: UIValues.ButtonHeight)
        self.DeleteButton.setLeadingAnchor(to: self.centerXAnchor, withPadding: UIValues.EdgePadding)
        self.DeleteButton.setTrailingAnchor(to: self.NameField.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
