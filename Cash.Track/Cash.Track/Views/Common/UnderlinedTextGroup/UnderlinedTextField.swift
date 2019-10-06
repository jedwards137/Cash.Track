//
//  UnderlinedTextField.swift
//  Cash.Track
//
//  Created by Jake Edwards on 4/15/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class UnderlinedTextField: UIView {
    internal var Field: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "field", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    internal var Underline: UIView = {
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
    
    convenience init(highlightColor: UIColor = .black, textAlignment: NSTextAlignment, placeholder: String, keyboardType: UIKeyboardType = .default, underlineColor: UIColor = .gray) {
        self.init(frame: CGRect.zero)
        Field.textAlignment = textAlignment
        Field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
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
        let number = Double(text)
        let numberIsValid = number != nil
        if numberIsValid {
            return number!
        }
        let invalidNumber: Double = -1
        return invalidNumber
    }
    
    internal func setupSelf() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    internal func anchorSubviews() {
        let subviews = [Field, Underline]
        subviews.forEach { self.addSubview($0) }
        
        Field.setTopAnchor(to: self.topAnchor)
        Field.setBottomAnchor(to: Underline.topAnchor)
        Field.setLeadingAnchor(to: self.leadingAnchor)
        Field.setTrailingAnchor(to: self.trailingAnchor)
        
        Underline.setHeightAnchor(to: 2)
        Underline.setBottomAnchor(to: self.bottomAnchor)
        Underline.setLeadingAnchor(to: self.leadingAnchor)
        Underline.setTrailingAnchor(to: self.trailingAnchor)
    }
    
    @objc private func textFieldEditingDidBegin(sender: UITextField) {
        Underline.backgroundColor = HighlightColor
    }
    
    @objc private func textFieldEditingDidEnd() {
        let fieldTextIsEmpty = Field.text!.isEmpty
        if fieldTextIsEmpty {
            Underline.backgroundColor = UnselectedUnderlineColor
        }
    }
}

