//
//  UIView.swift
//  QPay
//
//  Created by Dev. Mohmd on 7/2/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class TextViewDesign: UITextView {
    
    @IBInspectable var isCircle: Bool = false
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = .clear
    
    @IBInspectable var shadowColor: UIColor = .gray
    @IBInspectable var shadowOpacity: Float = 0
    @IBInspectable var shadowRadius: CGFloat = 0
    @IBInspectable var shadowOffset: CGSize = CGSize.init(width: 0, height: 0)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = false
        
        setCorner()
    }
    
    private func setCorner() {
        if self.isCircle {
            self.layer.cornerRadius = self.frame.height / 2
        }
    }
}
