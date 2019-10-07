//
//  UIViewControllerBase.swift
//  Cash.Track
//
//  Created by Jake Edwards on 7/12/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import Foundation
import UIKit

fileprivate protocol UIViewControllerProtocol : UIViewController {
    func setupPageView()
    func setupPageViewChildren()
}

public class UIViewControllerBase : UIViewController, UIViewControllerProtocol {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupPageView()
        setupPageViewChildren()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setupPageView() {
        fatalError("setupPageView not implemented")
    }
    
    func setupPageViewChildren() {
        fatalError("setupPageViewChildren not implemented")
    }
}
