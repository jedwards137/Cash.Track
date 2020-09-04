//
//  BudgetCell.swift
//  CashTrack
//
//  Created by Jake Edwards on 7/30/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

public class BudgetCell : UICollectionViewCell {
    private let ProgressView: UIProgressView = {
        let view = UIProgressView(frame: .zero)
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let NameLabel: UILabel = {
        let label = UILabel()
        label.text = "bucket"
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let SpentPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = label.font.withSize(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let AmountSpentLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let MonthlyAllocationLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .lightGray
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        addSubviews()
        anchorSubviews()
    }

    private func addSubviews() {
        let subviews = [self.NameLabel, self.SpentPercentageLabel, self.AmountSpentLabel, self.MonthlyAllocationLabel, self.ProgressView]
        subviews.forEach { subview in self.addSubview(subview) }
    }

    private func anchorSubviews() {
        self.ProgressView.setTopAnchor(to: self.NameLabel.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.ProgressView.setBottomAnchor(to: self.AmountSpentLabel.topAnchor, withPadding: -UIValues.EdgePadding)
        self.ProgressView.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.ProgressView.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        
        self.NameLabel.setTopAnchor(to: self.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.NameLabel.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        
        self.SpentPercentageLabel.setTopAnchor(to: self.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.SpentPercentageLabel.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        
        self.AmountSpentLabel.setBottomAnchor(to: self.bottomAnchor, withPadding: -2*UIValues.EdgePadding)
        self.AmountSpentLabel.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        
        self.MonthlyAllocationLabel.setBottomAnchor(to: self.bottomAnchor, withPadding: -2*UIValues.EdgePadding)
        self.MonthlyAllocationLabel.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
    }
    
    public func setBudgetInfoForCell(with budget: Budget) {
        self.NameLabel.text = budget.Name
        self.SpentPercentageLabel.text = "\(budget.PercentOfMonthlyAllocationSpent*100)%"
        self.AmountSpentLabel.text = "$\(budget.MonthlyAmountSpent)"
        self.MonthlyAllocationLabel.text = "$\(budget.MonthlyAllocation)"
        self.ProgressView.setProgress(budget.PercentOfMonthlyAllocationSpent, animated: true)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
