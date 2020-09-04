//
//  EditBudgetPageView.swift
//  CashTrack
//
//  Created by Jake Edwards on 9/1/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class EditBudgetPageView: UIViewBase {
    private let HighlightColor: UIColor = .blue
    private let UnderlineColor: UIColor = .black
    private(set) var NameField: UnderlinedTextField
    private(set) var MonthlyAllocationField: DollarUnderlinedTextField
    private(set) var PreviousPotField: DollarUnderlinedTextField
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
        self.NameField = UnderlinedTextField(title: "Name", highlightColor: HighlightColor, textAlignment: .left, placeholder: "Savings", keyboardType: .default, underlineColor: UnderlineColor)
        self.MonthlyAllocationField = DollarUnderlinedTextField(title: "Monthly Allocation", highlightColor: HighlightColor, textAlignment: .left, placeholder: "100.00", keyboardType: .numberPad, underlineColor: UnderlineColor)
        self.PreviousPotField = DollarUnderlinedTextField(title: "Previous Pot", highlightColor: HighlightColor, textAlignment: .left, placeholder: "100.00", keyboardType: .numberPad, underlineColor: UnderlineColor)
        
        super.init()
        self.backgroundColor = .white
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponderHandler))
            self.addGestureRecognizer(tapRecognizer)
    }
    
    public func setInfoFor(_ budget: Budget) {
        self.NameField.Field.text = "\(budget.Name)"
        self.MonthlyAllocationField.Field.text = "\(budget.MonthlyAllocation)"
        self.PreviousPotField.Field.text = "\(budget.PreviousPot)"
    }
        
    @objc private func resignFirstResponderHandler() {
        self.endEditing(true)
    }
        
    internal override func addSubviews() {
        let subviews = [self.NameField, self.MonthlyAllocationField, self.PreviousPotField, self.UpdateButton, self.DeleteButton]
        subviews.forEach { subview in self.addSubview(subview) }
    }
    
    internal override func anchorSubviews() {
        self.NameField.setTopAnchor(to: self.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.NameField.setHeightAnchor(to: UIValues.FieldHeight)
        self.NameField.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.NameField.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        
        self.MonthlyAllocationField.setTopAnchor(to: self.NameField.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.MonthlyAllocationField.setHeightAnchor(to: UIValues.FieldHeight)
        self.MonthlyAllocationField.setLeadingAnchor(to: self.NameField.leadingAnchor)
        self.MonthlyAllocationField.setTrailingAnchor(to: self.centerXAnchor, withPadding: -UIValues.EdgePadding)
        
        self.PreviousPotField.setTopAnchor(to: self.MonthlyAllocationField.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.PreviousPotField.setHeightAnchor(to: UIValues.FieldHeight)
        self.PreviousPotField.setLeadingAnchor(to: self.centerXAnchor, withPadding: UIValues.EdgePadding)
        self.PreviousPotField.setTrailingAnchor(to: self.NameField.trailingAnchor)
        
        self.UpdateButton.setTopAnchor(to: self.MonthlyAllocationField.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.UpdateButton.setHeightAnchor(to: UIValues.ButtonHeight)
            self.UpdateButton.setLeadingAnchor(to: self.NameField.leadingAnchor)
        self.UpdateButton.setTrailingAnchor(to: self.centerXAnchor, withPadding: -UIValues.EdgePadding)
        
        self.DeleteButton.setTopAnchor(to: self.UpdateButton.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.DeleteButton.setHeightAnchor(to: UIValues.ButtonHeight)
        self.DeleteButton.setLeadingAnchor(to: self.centerXAnchor, withPadding: UIValues.EdgePadding)
        self.DeleteButton.setTrailingAnchor(to: self.NameField.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
