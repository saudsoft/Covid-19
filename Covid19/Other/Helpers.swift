//
//  Helpers.swift
//  Covid19
//
//  Created by Saud Almutlaq on 09/06/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import Foundation
import UIKit

//MARK: Extentions
/// Add border to UIButton like the buttons on AppStore
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
            self.contentEdgeInsets.top = 5
            self.contentEdgeInsets.bottom = 5
            self.contentEdgeInsets.right = 10
            self.contentEdgeInsets.left = 10
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension String {
    func convertToArbic () -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "EN")
        guard let number = formatter.number(from:self ) else{
            return nil
        }
        formatter.locale = Locale(identifier: "AR")
        guard let number2 = formatter.string(from: number) else{
            return nil
        }
        return number2
    }
}
