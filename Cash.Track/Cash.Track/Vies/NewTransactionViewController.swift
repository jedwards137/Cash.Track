//
//  NewTransactionViewController.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewControllerBase {
    private var PageView = NewTransactionPageView()
    
    override func setupNavBar() {
        super.setupNavBar()
        self.title = "New Transaction"
    }
    
    override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.topAnchor)
        PageView.setBottomAnchor(to: self.view.bottomAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
    }
    
    internal override func setupPageViewChildren() {
        
    }
    
    

}
