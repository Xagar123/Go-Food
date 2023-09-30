//
//  Extension+UIView.swift
//  GoFood
//
//  Created by Sagar Das on 19/09/23.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}
