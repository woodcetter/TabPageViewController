//
//  UIViewController+LayoutGuide.swift
//  TabPageViewController
//
//  Created by sykim on 19/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import Foundation
import SnapKit

extension UIViewController {
    var topLayout: ConstraintItem {
        var top: ConstraintItem!
        if #available(iOS 11.0, *) {
            top = self.view.safeAreaLayoutGuide.snp.top
        } else {
            top = self.topLayoutGuide.snp.top
        }
        return top
    }
    
    var bottomLayout: ConstraintItem {
        var bottom: ConstraintItem!
        if #available(iOS 11.0, *) {
            bottom = self.view.safeAreaLayoutGuide.snp.bottom
        } else {
            bottom = self.bottomLayoutGuide.snp.bottom
        }
        return bottom
    }
}
