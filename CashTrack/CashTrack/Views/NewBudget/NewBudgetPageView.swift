//
//  NewBudgetPageView.swift
//  CashTrack
//
//  Created by Jake Edwards on 8/14/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class NewBudgetPageView: UIViewBase {
    private let HighlightColor: UIColor = .blue
    private let UnderlineColor: UIColor = .black
    private(set) var NameField: UnderlinedTextField
    private(set) var MonthlyAllocationField: DollarUnderlinedTextField
    private(set) var PreviousPotField: DollarUnderlinedTextField
    private(set) var SubmitButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init() {
        self.NameField = UnderlinedTextField(title: "Name", highlightColor: HighlightColor, textAlignment: .left, placeholder: "Savings", keyboardType: .default, underlineColor: UnderlineColor)
        self.MonthlyAllocationField = DollarUnderlinedTextField(title: "Monthly Allocation", highlightColor: HighlightColor, textAlignment: .left, placeholder: "100.00", keyboardType: .numberPad, underlineColor: UnderlineColor)
        self.PreviousPotField = DollarUnderlinedTextField(title: "Previous Pot", highlightColor: HighlightColor, textAlignment: .left, placeholder: "100.00", keyboardType: .numberPad, underlineColor: UnderlineColor)
        
        super.init()
        self.backgroundColor = .white
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponderHandler))
            self.addGestureRecognizer(tapRecognizer)
    }
        
    @objc private func resignFirstResponderHandler() {
        self.endEditing(true)
    }
        
    internal override func addSubviews() {
        let subviews = [self.NameField, self.MonthlyAllocationField, self.PreviousPotField, self.SubmitButton]
        subviews.forEach { subview in self.addSubview(subview) }
    }
    
    internal override func anchorSubviews() {
        self.NameField.setTopAnchor(to: self.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.NameField.setHeightAnchor(to: UIValues.FieldHeight)
        self.NameField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.NameField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        
        self.MonthlyAllocationField.setTopAnchor(to: self.NameField.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.MonthlyAllocationField.setHeightAnchor(to: UIValues.FieldHeight)
        self.MonthlyAllocationField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.MonthlyAllocationField.setTrailingAnchor(to: self.centerXAnchor, withPadding: -UIValues.EdgePadding)
        
        self.PreviousPotField.setTopAnchor(to: self.MonthlyAllocationField.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.PreviousPotField.setHeightAnchor(to: UIValues.FieldHeight)
        self.PreviousPotField.setLeadingAnchor(to: self.centerXAnchor, withPadding: UIValues.EdgePadding)
        self.PreviousPotField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        
        self.SubmitButton.setTopAnchor(to: self.MonthlyAllocationField.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.SubmitButton.setHeightAnchor(to: 50)
        self.SubmitButton.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.SubmitButton.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
