//
//  NewWalletViewController.swift
//  Cash.Track
//
//  Created by Jake Edwards on 7/28/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class NewWalletViewController: UIViewControllerBase {
    private var PageView = NewWalletPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Wallet"
        self.view.backgroundColor = UIColor(r: 156, g: 175, b: 183)
    }
    
    internal override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor, withPadding: 2*EdgePadding)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor, withPadding: -2*EdgePadding)
        PageView.setBottomAnchor(to: self.view.bottomAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.SubmitButton.addTarget(self, action: #selector(submitTransaction), for: .touchUpInside)
    }
    
    @objc private func submitTransaction() {
        let name = PageView.NameField.getText()
        
        let addWalletResult = Store.shared.addWalletWith(name: name)
        if !addWalletResult { return }
        
        self.navigationController?.popViewController(animated: true)
    }
}
