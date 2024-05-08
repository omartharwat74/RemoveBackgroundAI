//
//  Extension + UIVIew.swift
//  SolvingMathematicalEquations
//
//  Created by Omar Tharwat on 28/04/2024.
//

import Foundation
import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            parentResponder = responder.next
        }
        return nil
    }
}

    public func SCImage(named name: String) -> UIImage? {
        UIImage(named: name, in: Bundle.module, compatibleWith: nil)
    }

