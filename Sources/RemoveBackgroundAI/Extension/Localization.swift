//
//  UILabel+Localization.swift
//  ImageGeneration
//
//  Created by Omar Tharwat on 22/04/2024.
//

import Foundation
import UIKit


extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle.module, comment: "")
    }
    
    func localized(_ arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}

extension UILabel {
    @IBInspectable var translationKey: String? {
        get {
            return nil
        }
        set {
            if let key = newValue {
                text = key.localized
            } else {
                assertionFailure("Translation key not set for UILabel")
            }
        }
    }
}
