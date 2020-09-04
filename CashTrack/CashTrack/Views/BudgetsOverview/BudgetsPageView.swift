//
//  BudgetsPageView.swift
//  CashTrack
//
//  Created by Jake Edwards on 7/30/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class BudgetsPageView: UIViewBase {
    private var PreviousPotView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let CurrentPotTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Pot"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var PreviousPotAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var MonthlyAllocationView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let MonthlyAllocationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Allocated"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var MonthlyAllocationAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var MonthlySpentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let MonthlySpentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Spent"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var MonthlySpentAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 30)
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
        let subviews = [self.PreviousPotView, self.CurrentPotTitleLabel, self.PreviousPotAmountLabel, self.MonthlySpentView, self.MonthlySpentTitleLabel, self.MonthlySpentAmountLabel, self.MonthlyAllocationView, self.MonthlyAllocationTitleLabel, self.MonthlyAllocationAmountLabel, self.BudgetsCollectionView]
        subviews.forEach { subview in self.addSubview(subview) }
    }
    
    internal override func anchorSubviews() {
        anchorPreviousPotView()
        anchorSpentView()
        anchorMonthlyAllocationView()
        
        self.BudgetsCollectionView.setTopAnchor(to: self.MonthlySpentView.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.BudgetsCollectionView.setBottomAnchor(to: self.bottomAnchor)
        self.BudgetsCollectionView.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.BudgetsCollectionView.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
    }
    
    private func anchorPreviousPotView() {
        self.PreviousPotView.setTopAnchor(to: self.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.PreviousPotView.setHeightAnchor(to: 115)
        self.PreviousPotView.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.PreviousPotView.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        
        self.CurrentPotTitleLabel.setTopAnchor(to: self.PreviousPotView.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.CurrentPotTitleLabel.setLeadingAnchor(to: self.PreviousPotView.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        
        self.PreviousPotAmountLabel.setBottomAnchor(to: self.PreviousPotView.bottomAnchor, withPadding: -2*UIValues.EdgePadding)
        self.PreviousPotAmountLabel.setLeadingAnchor(to: self.PreviousPotView.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
    }
    
    private func anchorSpentView() {
        self.MonthlySpentView.setTopAnchor(to: self.PreviousPotView.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.MonthlySpentView.setHeightAnchor(to: 95)
        self.MonthlySpentView.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.MonthlySpentView.setTrailingAnchor(to: self.centerXAnchor, withPadding: -UIValues.EdgePadding)
        
        self.MonthlySpentTitleLabel.setTopAnchor(to: self.MonthlySpentView.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.MonthlySpentTitleLabel.setLeadingAnchor(to: self.MonthlySpentView.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        
        self.MonthlySpentAmountLabel.setBottomAnchor(to: self.MonthlySpentView.bottomAnchor, withPadding: -2*UIValues.EdgePadding)
        self.MonthlySpentAmountLabel.setLeadingAnchor(to: self.MonthlySpentView.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
    }
    
    private func anchorMonthlyAllocationView() {
        self.MonthlyAllocationView.setTopAnchor(to: self.PreviousPotView.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.MonthlyAllocationView.setHeightAnchor(to: 95)
        self.MonthlyAllocationView.setLeadingAnchor(to: self.centerXAnchor, withPadding: UIValues.EdgePadding)
        self.MonthlyAllocationView.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        
        self.MonthlyAllocationTitleLabel.setTopAnchor(to: self.MonthlyAllocationView.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.MonthlyAllocationTitleLabel.setLeadingAnchor(to: self.MonthlyAllocationView.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        
        self.MonthlyAllocationAmountLabel.setBottomAnchor(to: self.MonthlyAllocationView.bottomAnchor, withPadding: -2*UIValues.EdgePadding)
        self.MonthlyAllocationAmountLabel.setLeadingAnchor(to: self.MonthlyAllocationView.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
