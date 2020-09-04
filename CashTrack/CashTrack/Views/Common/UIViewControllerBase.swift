//
//  UIViewControllerBase.swift
//  CashTrack
//
//  Created by Jake Edwards on 7/30/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import Foundation
import UIKit

fileprivate protocol UIViewControllerProtocol: UIViewController {
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
        self.navigationController?.view.backgroundColor = .blue
        let attrs = [ NSAttributedString.Key.foregroundColor: UIColor.black ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attrs
    }
    
    func setupPageView() {
        fatalError("setupPageView not implemented")
    }
    
    func setupPageViewChildren() {
        fatalError("setupPageViewChildren not implemented")
    }
}
