//
//  BudgetFooterView.swift
//  CashTrack
//
//  Created by Jake Edwards on 8/12/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import Foundation
import UIKit

public class BudgetFooterView: UICollectionReusableView {
    private let InfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap To Add New Budget"
        label.textColor = .blue
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        addSubviews()
        anchorSubviews()
    }
        
    private func addSubviews() {
        let subviews = [self.InfoLabel]
        subviews.forEach { subview in self.addSubview(subview) }
    }

    private func anchorSubviews() {
        self.InfoLabel.setCenterXAnchor(to: self.centerXAnchor)
        self.InfoLabel.setCenterYAnchor(to: self.centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
