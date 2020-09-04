//
//  BudgetsPageView.swift
//  CashTrack
//
//  Created by Jake Edwards on 7/30/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class BudgetsPageView: UIViewBase {
    private let OverviewTitle: UILabel = {
        let label = UILabel()
        label.text = "OVERVIEW"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: UIValues.TitleSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var CurrentPotLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Pot"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: UIValues.LabelSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var CurrentPotAmount: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: UIValues.LabelSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let CashFlowTitle: UILabel = {
        let label = UILabel()
        label.text = "CASH FLOW"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: UIValues.TitleSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var AllocatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Allocated"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: UIValues.LabelSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var AllocatedAmount: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: UIValues.LabelSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let SpentLabel: UILabel = {
        let label = UILabel()
        label.text = "Spent"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: UIValues.LabelSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var SpentAmount: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: UIValues.LabelSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var NetAmount: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .blue
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let BudgetsTitle: UILabel = {
        let label = UILabel()
        label.text = "BUDGETS"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: UIValues.TitleSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var BudgetsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init() {
        super.init()
        self.backgroundColor = .white
    }
    
    internal override func addSubviews() {
        let subviews = [self.OverviewTitle, self.CurrentPotLabel, self.CurrentPotAmount, self.CashFlowTitle, self.AllocatedLabel, self.AllocatedAmount, self.SpentLabel, self.SpentAmount, self.NetAmount, self.BudgetsTitle, self.BudgetsCollectionView]
        subviews.forEach { subview in self.addSubview(subview) }
    }
    
    internal override func anchorSubviews() {
        anchorOverviewSection()
        anchorCashflowSection()
        anchorBudgetsSection()
    }
    
    private func anchorOverviewSection() {
        self.OverviewTitle.setTopAnchor(to: self.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.OverviewTitle.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        
        self.CurrentPotLabel.setTopAnchor(to: self.OverviewTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.CurrentPotLabel.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.CurrentPotAmount.setTopAnchor(to: self.OverviewTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.CurrentPotAmount.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
    }
    
    private func anchorCashflowSection() {
        self.CashFlowTitle.setTopAnchor(to: self.CurrentPotLabel.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.CashFlowTitle.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.AllocatedLabel.setTopAnchor(to: self.CashFlowTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.AllocatedLabel.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.AllocatedAmount.setTopAnchor(to: self.CashFlowTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.AllocatedAmount.setTrailingAnchor(to: self.centerXAnchor)
        
        self.SpentLabel.setTopAnchor(to: self.AllocatedLabel.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.SpentLabel.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.SpentAmount.setTopAnchor(to: self.AllocatedLabel.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.SpentAmount.setTrailingAnchor(to: self.centerXAnchor)
        
        self.NetAmount.setTopAnchor(to: self.AllocatedLabel.topAnchor)
        self.NetAmount.setBottomAnchor(to: self.SpentLabel.bottomAnchor)
        self.NetAmount.setTrailingAnchor(to: self.CurrentPotAmount.trailingAnchor)
    }
    
    private func anchorBudgetsSection() {
        self.BudgetsTitle.setTopAnchor(to: self.SpentLabel.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.BudgetsTitle.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.BudgetsCollectionView.setTopAnchor(to: self.BudgetsTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.BudgetsCollectionView.setBottomAnchor(to: self.bottomAnchor, withPadding: -2*UIValues.EdgePadding)
        self.BudgetsCollectionView.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        self.BudgetsCollectionView.setTrailingAnchor(to: self.CurrentPotAmount.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
