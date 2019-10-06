//
//  NewWalletPageView.swift
//  Cash.Track
//
//  Created by Jake Edwards on 7/28/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class NewWalletPageView: UIViewBase {
    private(set) var NameField = UnderlinedTextField(highlightColor: .white, textAlignment: .left, placeholder: "name", underlineColor: .black)
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
    }
    
    internal override func addSubviews() {
        let subviews = [NameField, SubmitButton]
        subviews.forEach { self.addSubview($0) }
    }
    
    internal override func anchorSubviews() {
        
        NameField.setTopAnchor(to: self.topAnchor, withPadding: 3*EdgePadding)
        NameField.setHeightAnchor(to: FieldHeight)
        NameField.setLeadingAnchor(to: self.leadingAnchor)
        NameField.setTrailingAnchor(to: self.trailingAnchor)
        
        SubmitButton.setTopAnchor(to: NameField.bottomAnchor, withPadding: 4*EdgePadding)
        SubmitButton.setHeightAnchor(to: 50)
        SubmitButton.setLeadingAnchor(to: self.leadingAnchor)
        SubmitButton.setTrailingAnchor(to: self.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
