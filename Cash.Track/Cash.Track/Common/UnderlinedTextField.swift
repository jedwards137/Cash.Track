//
//  UnderlinedTextField.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import Foundation
import UIKit

class UnderlinedTextField : UIView {
    private var Title: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var Field: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "field", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private(set) var Underline: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    internal var HighlightColor: UIColor!
    internal var UnselectedUnderlineColor: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
        anchorSubviews()
    }
    
    convenience init(title: String, highlightColor: UIColor = .black, textAlignment: NSTextAlignment, placeholder: String, keyboardType: UIKeyboardType = .default, underlineColor: UIColor = .gray) {
        self.init(frame: CGRect.zero)
        Title.text = title
        Title.textColor = highlightColor
        Title.textAlignment = textAlignment
        Field.textAlignment = textAlignment
        Field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        Field.keyboardType = keyboardType
        Underline.backgroundColor = underlineColor
        HighlightColor = highlightColor
        UnselectedUnderlineColor = underlineColor
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    public func reset() {
        Field.text = ""
        Field.endEditing(true)
        Underline.backgroundColor = .gray
    }
    
    public func getText() -> String {
        let text = Field.text ?? ""
        return text
    }
    
    public func getDouble() -> Double {
        let text = getText()
        guard let number : Double = Double(text) else { return 0 }
        return number
    }
    
    public func hasText() -> Bool {
        let text = getText()
        let hasText = text.count > 0
        return hasText
    }
    
    public func hasDouble() -> Bool {
        let double = getDouble()
        let hasDouble = double != 0
        return hasDouble
    }
    
    internal func setupSelf() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    internal func anchorSubviews() {
        let subviews = [Title, Field, Underline]
        subviews.forEach { self.addSubview($0) }
        
        Title.setTopAnchor(to: self.topAnchor)
        Title.setLeadingAnchor(to: self.leadingAnchor)
        Title.setTrailingAnchor(to: self.trailingAnchor)
        Title.setHeightAnchor(to: 20)
        
        Field.setTopAnchor(to: Title.bottomAnchor)
        Field.setBottomAnchor(to: Underline.topAnchor)
        Field.setLeadingAnchor(to: self.leadingAnchor)
        Field.setTrailingAnchor(to: self.trailingAnchor)
        
        Underline.setHeightAnchor(to: 2)
        Underline.setBottomAnchor(to: self.bottomAnchor)
        Underline.setLeadingAnchor(to: self.leadingAnchor)
        Underline.setTrailingAnchor(to: self.trailingAnchor)
    }
    
    @objc internal func textFieldEditingDidBegin(sender: UITextField) {
        Underline.backgroundColor = HighlightColor
    }
    
    @objc private func textFieldEditingDidEnd() {
        let fieldTextIsEmpty = Field.text!.isEmpty
        if fieldTextIsEmpty {
            Underline.backgroundColor = UnselectedUnderlineColor
        }
    }
}
