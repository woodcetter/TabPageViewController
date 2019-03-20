//
//  CALayout+Border.swift
//  TabPageViewController
//
//  Created by sykim on 20/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat = CGFloat(1), isRemove: Bool = true) {
        if isRemove {
            self.removeBorder()
        }
        
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            border.name = "addBorder"
            self.addSublayer(border)
        }
    }
    
    func removeBorder() {
        guard let sublayers = self.sublayers else { return }
        
        for layer in sublayers {
            if layer.name == "addBorder" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
}
