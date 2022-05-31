//
//  CustomTabBar.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/13/22.
//


// learning how to do this, I used this Youtube video for reference https://www.youtube.com/watch?v=_N4lxebmJ2U&list=LL&index=3

import UIKit

class CustomTabBar: UITabBar {

    private var shapeLayer: CALayer?
        
        private func addShape() {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = createPath()
            shapeLayer.strokeColor = UIColor.clear.cgColor
            shapeLayer.fillColor = UIColor.white.cgColor
            shapeLayer.lineWidth = 1.0
            
            if let oldShapeLayer = self.shapeLayer {
                self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
            } else {
                self.layer.insertSublayer(shapeLayer, at: 0)
            }
            self.shapeLayer = shapeLayer
        }
        
        override func draw(_ rect: CGRect) {
            self.addShape()
            self.unselectedItemTintColor = UIColor.darkGray
            self.tintColor = Primary.shared.uiColor
        }

        func createPath() -> CGPath {
            let height: CGFloat = -10
            let path = UIBezierPath()
            let centerWidth = self.frame.width / 2
       
            path.move(to: CGPoint(x: 0, y: 0))
            path.addQuadCurve(to: CGPoint(x: self.frame.width, y: 0), controlPoint: CGPoint(x: centerWidth, y: height))
            path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
            path.addLine(to: CGPoint(x: 0, y: self.frame.height))
            path.close()
            
            return path.cgPath
        }

}
