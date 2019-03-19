//
//  UIView+LayoutGuide.swift
//  TabPageViewController
//
//  Created by sykim on 19/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    var topLayout: ConstraintItem {
        var top: ConstraintItem!
        if #available(iOS 11.0, *) {
            top = self.safeAreaLayoutGuide.snp.top
        } else {
            top = self.snp.top
        }
        return top
    }
    
    var bottomLayout: ConstraintItem {
        var bottom: ConstraintItem!
        if #available(iOS 11.0, *) {
            bottom = self.safeAreaLayoutGuide.snp.bottom
        } else {
            bottom = self.snp.bottom
        }
        return bottom
    }
}
