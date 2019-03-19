//
//  TabBarViewModel.swift
//  TabPageViewController
//
//  Created by sykim on 19/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit

protocol ContainTabBar {
    var titles: [String] { get set }
    var titleImages: [UIImage]? { get set }
    var underScoreView: UIView? { get set }
}

struct TabBarViewModel: ContainTabBar {
    var titles: [String] = []
    var titleImages: [UIImage]?
    var underScoreView: UIView?
    
    init(titles: [String], titleImages: [UIImage]? = nil, underScoreView: UIView? = nil) {
        self.titles = titles
        self.titleImages = titleImages
        self.underScoreView = underScoreView
    }
}
