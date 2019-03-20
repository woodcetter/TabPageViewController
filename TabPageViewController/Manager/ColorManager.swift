//
//  ColorManager.swift
//  TabPageViewController
//
//  Created by sykim on 19/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit

struct Color {
    static let black = ColorUtil.getColor(with: 0x333333)
    static let green = ColorUtil.getColor(with: 0x00af7f)
    static let navy = ColorUtil.getColor(with: 0x000080)
}

//enum MainColor {
//    case tema
//}
//
//extension MainColor {
//    var color: UIColor {
//        var _color: UIColor!
//        switch self {
//        case .tema:
//            _color = .green
//        return _color
//        }
//    }
//}

extension UIColor {
    /// 기본 테마 색상 (green)
    open class var tema: UIColor {
        return .green
    }
    
    /// 기본 검정 색상 0x333333
    open class var black: UIColor {
        return Color.black
    }
    
    /// 기본 초록 색상 0x00af7f
    open class var green: UIColor {
        return Color.green
    }
    
    open class var navy: UIColor {
        return Color.navy
    }
}
