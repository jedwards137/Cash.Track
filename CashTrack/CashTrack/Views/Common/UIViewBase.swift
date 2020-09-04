//
//  UIViewBase.swift
//  CashTrack
//
//  Created by Jake Edwards on 7/30/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import Foundation
import UIKit

fileprivate protocol UIViewProtocol : UIView {
    func addSubviews()
    func anchorSubviews()
}

public class UIViewBase : UIView, UIViewProtocol {
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        addSubviews()
        anchorSubviews()
    }
    
    func addSubviews() {
        fatalError("addSubviews not implemented")
    }
    
    func anchorSubviews() {
        fatalError("anchorSubviews not implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
