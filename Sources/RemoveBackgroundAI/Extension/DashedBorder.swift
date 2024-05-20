//
//  File.swift
//
//
//  Created by Omar Tharwat on 14/05/2024.
//

import UIKit

class RectangularDashedView: UIView {
    
    var dashBorder: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Only create the dashBorder layer if it hasn't been created yet
        if dashBorder == nil {
            let dashBorder = CAShapeLayer()
            dashBorder.lineWidth = 0.5
            dashBorder.strokeColor = UIColor(red: 0.341, green: 0.584, blue: 0.58, alpha: 1).cgColor
            dashBorder.lineDashPattern = [10, 5]
            dashBorder.fillColor = nil
            layer.addSublayer(dashBorder)
            self.dashBorder = dashBorder
        }
        
        // Update the dashBorder layer's properties and path
        dashBorder?.frame = bounds
        dashBorder?.path = UIBezierPath(roundedRect: bounds, cornerRadius: 25).cgPath
    }
    
    func hideDashBorder() {
        dashBorder?.isHidden = true
    }
    
    func showDashBorder() {
        dashBorder?.isHidden = false
    }
}
