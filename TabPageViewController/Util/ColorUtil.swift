//
//  ColorUtil.swift
//  TabPageViewController
//
//  Created by sykim on 19/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit

final class ColorUtil: NSObject {
    
    static func getColor(with hexCode: Int, alpha: CGFloat = CGFloat(1)) -> UIColor {
        let r = (CGFloat)((hexCode & 0xFF0000) >> 16) / 255.0
        let g = (CGFloat)((hexCode & 0xFF00) >> 8) / 255.0
        let b = (CGFloat)((hexCode & 0xFF)) / 255.0
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: alpha)
    }
}
