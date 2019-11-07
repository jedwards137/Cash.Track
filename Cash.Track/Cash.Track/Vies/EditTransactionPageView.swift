//
//  EditTransactionPageView.swift
//  Cash.Track
//
//  Created by Jake Edwards on 11/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class EditTransactionPageView: UIViewBase {
    private(set) var TransactionNameField = UnderlinedTextField(title: "Name", highlightColor: .black, textAlignment: .left, placeholder: "Transaction #1", underlineColor: .lightGray)
    private(set) var TransactionTypeField = TransactionTypeUnderlinedTextField(title: "Transaction Type", highlightColor: .black, textAlignment: .left, placeholder: "Deposit", underlineColor: .lightGray)
    private(set) var AmountField = UnderlinedTextField(title: "Amount", highlightColor: .black, textAlignment: .left, placeholder: "0.00", keyboardType: .decimalPad, underlineColor: .lightGray)
    private(set) var DateField = DateUnderlinedTextField(title: "Date", highlightColor: .black, textAlignment: .left, placeholder: "Jan 1, 2000", underlineColor: .lightGray)
    private(set) var SubmitButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init() {
        super.init()
        self.backgroundColor = .white
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponderHandler))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    public func setTransactionInfo(with transaction: Transaction) {
        TransactionNameField.Field.text = transaction.Name
        TransactionTypeField.Field.text = transaction.TransType.rawValue
        AmountField.Field.text = "\(transaction.Amount)"
        DateField.Field.text = transaction.Date.toReadable()
    }
    
    @objc private func resignFirstResponderHandler() {
        self.endEditing(true)
    }
    
    internal override func addSubviews() {
        let subviews = [TransactionNameField, TransactionTypeField, AmountField, DateField, SubmitButton]
        subviews.forEach { self.addSubview($0) }
    }
    
    internal override func anchorSubviews() {
        TransactionNameField.setTopAnchor(to: self.safeAreaLayoutGuide.topAnchor, withPadding: 2*EdgePadding)
        TransactionNameField.setHeightAnchor(to: FieldHeight)
        TransactionNameField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        TransactionNameField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        TransactionTypeField.setTopAnchor(to: TransactionNameField.bottomAnchor, withPadding: 3*EdgePadding)
        TransactionTypeField.setHeightAnchor(to: FieldHeight)
        TransactionTypeField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        TransactionTypeField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        AmountField.setTopAnchor(to: TransactionTypeField.bottomAnchor, withPadding: 3*EdgePadding)
        AmountField.setHeightAnchor(to: FieldHeight)
        AmountField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        AmountField.setTrailingAnchor(to: self.centerXAnchor, withPadding: -EdgePadding)
        
        DateField.setTopAnchor(to: AmountField.topAnchor)
        DateField.setHeightAnchor(to: FieldHeight)
        DateField.setLeadingAnchor(to: self.centerXAnchor, withPadding: EdgePadding)
        DateField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        SubmitButton.setTopAnchor(to: DateField.bottomAnchor, withPadding: 4*EdgePadding)
        SubmitButton.setHeightAnchor(to: 50)
        SubmitButton.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        SubmitButton.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
