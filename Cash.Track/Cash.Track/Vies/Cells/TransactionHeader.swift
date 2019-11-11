//
//  TransactionHeader.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import Foundation
import UIKit

public class TransactionHeader : UICollectionReusableView {
    private let NameLabel : UILabel = {
        let label = UILabel()
        label.text = "date title"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        addSubviews()
        anchorSubviews()
    }
    
    public func setSectionDate(to date: Date) {
        NameLabel.text = date.toReadable(withTimeStyle: .none)
    }
    
    private func addSubviews() {
        self.addSubview(NameLabel)
    }
    
    private func anchorSubviews() {
        let edgePadding : CGFloat = 10
        NameLabel.setLeadingAnchor(to: self.leadingAnchor)
        NameLabel.setBottomAnchor(to: self.bottomAnchor, withPadding: -edgePadding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
