//
//  NewTransactionPageView.swift
//  Cash.Track
//
//  Created by Jake Edwards on 7/13/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class NewTransactionPageView : UIViewBase {
    private(set) var TransactionNameField = UnderlinedTextField(highlightColor: .white, textAlignment: .left, placeholder: "name", underlineColor: .gray)
    private(set) var TransactionTypeField = TransactionTypeUnderlinedTextField(highlightColor: .red, textAlignment: .left, placeholder: "deposit / withdrawal", underlineColor: .white)
    private(set) var AmountField = UnderlinedTextField(highlightColor: .white, textAlignment: .left, placeholder: "amount", keyboardType: .decimalPad, underlineColor: .gray)
    private(set) var DateField = DateUnderlinedTextField(highlightColor: .white, textAlignment: .left, placeholder: "date", underlineColor: .gray)
    private(set) var SubmitButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init() {
        super.init()
        self.backgroundColor = .clear
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponderHandler))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func resignFirstResponderHandler() {
        self.endEditing(true)
    }
    
    internal override func addSubviews() {
        let subviews = [TransactionNameField, TransactionTypeField, AmountField, DateField, SubmitButton]
        subviews.forEach { self.addSubview($0) }
    }
    
    internal override func anchorSubviews() {
        TransactionNameField.setTopAnchor(to: self.topAnchor, withPadding: 3*EdgePadding)
        TransactionNameField.setHeightAnchor(to: FieldHeight)
        TransactionNameField.setLeadingAnchor(to: self.leadingAnchor)
        TransactionNameField.setTrailingAnchor(to: self.trailingAnchor)
        
        TransactionTypeField.setTopAnchor(to: TransactionNameField.bottomAnchor, withPadding: 3*EdgePadding)
        TransactionTypeField.setHeightAnchor(to: FieldHeight)
        TransactionTypeField.setLeadingAnchor(to: self.leadingAnchor)
        TransactionTypeField.setTrailingAnchor(to: self.trailingAnchor)
        
        AmountField.setTopAnchor(to: TransactionTypeField.bottomAnchor, withPadding: 3*EdgePadding)
        AmountField.setHeightAnchor(to: FieldHeight)
        AmountField.setLeadingAnchor(to: self.leadingAnchor)
        AmountField.setTrailingAnchor(to: self.centerXAnchor, withPadding: -EdgePadding)
        
        DateField.setTopAnchor(to: AmountField.topAnchor)
        DateField.setHeightAnchor(to: FieldHeight)
        DateField.setLeadingAnchor(to: self.centerXAnchor, withPadding: EdgePadding)
        DateField.setTrailingAnchor(to: self.trailingAnchor)
        
        SubmitButton.setTopAnchor(to: DateField.bottomAnchor, withPadding: 4*EdgePadding)
        SubmitButton.setHeightAnchor(to: 50)
        SubmitButton.setLeadingAnchor(to: self.leadingAnchor)
        SubmitButton.setTrailingAnchor(to: self.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
