//
//  NewTransactionPageView.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class NewTransactionPageView: UIViewBase {
    private let HighlightColor : UIColor = .black
    private let UnderlineColor : UIColor = .lightGray
    private(set) var TransactionNameField : UnderlinedTextField
    private(set) var TransactionTypeField : TransactionTypeUnderlinedTextField
    private(set) var AmountField : DollarUnderlinedTextField
    private(set) var DateTimeField : DateTimeUnderlinedTextField
    private(set) var SubmitButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = GlobalValues.customGreen
        button.layer.cornerRadius = 8
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init() {
        TransactionNameField = UnderlinedTextField(title: "Name", highlightColor: HighlightColor, textAlignment: .left, placeholder: "Transaction #1", underlineColor: UnderlineColor)
        TransactionTypeField = TransactionTypeUnderlinedTextField(title: "Transaction Type", highlightColor: HighlightColor, textAlignment: .left, placeholder: "Deposit", underlineColor: UnderlineColor)
        AmountField = DollarUnderlinedTextField(title: "Amount", highlightColor: HighlightColor, textAlignment: .left, placeholder: "0.00", keyboardType: .decimalPad, underlineColor: UnderlineColor)
        DateTimeField = DateTimeUnderlinedTextField(title: "Date", highlightColor: HighlightColor, textAlignment: .left, placeholder: "Jan 1, 2000 at 11:00 AM", underlineColor: UnderlineColor)
        
        super.init()
        
        self.backgroundColor = .white
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponderHandler))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func resignFirstResponderHandler() {
        self.endEditing(true)
    }
    
    public override func addSubviews() {
        let subviews = [TransactionNameField, TransactionTypeField, AmountField, DateTimeField, SubmitButton]
        subviews.forEach { self.addSubview($0) }
    }
    
    public override func anchorSubviews() {
        TransactionNameField.setTopAnchor(to: self.safeAreaLayoutGuide.topAnchor, withPadding: 2*EdgePadding)
        TransactionNameField.setHeightAnchor(to: FieldHeight)
        TransactionNameField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        TransactionNameField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        TransactionTypeField.setTopAnchor(to: TransactionNameField.bottomAnchor, withPadding: 3*EdgePadding)
        TransactionTypeField.setHeightAnchor(to: FieldHeight)
        TransactionTypeField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        TransactionTypeField.setTrailingAnchor(to: self.centerXAnchor, withPadding: -EdgePadding)
        
        AmountField.setTopAnchor(to: TransactionTypeField.topAnchor)
        AmountField.setHeightAnchor(to: FieldHeight)
        AmountField.setLeadingAnchor(to: self.centerXAnchor, withPadding: EdgePadding)
        AmountField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        DateTimeField.setTopAnchor(to: TransactionTypeField.bottomAnchor, withPadding: 2*EdgePadding)
        DateTimeField.setHeightAnchor(to: FieldHeight)
        DateTimeField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        DateTimeField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        SubmitButton.setTopAnchor(to: DateTimeField.bottomAnchor, withPadding: 4*EdgePadding)
        SubmitButton.setHeightAnchor(to: 50)
        SubmitButton.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        SubmitButton.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
