//
//  TabBarViewModel.swift
//  TabPageViewController
//
//  Created by sykim on 19/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit

protocol ContainTabBar {
    var title: String { get set }
    var titleImage: UIImage? { get set }
}

struct TabBarViewModel: ContainTabBar {
    var title: String
    var titleImage: UIImage?
    
    init(title: String, titleImage: UIImage? = nil) {
        self.title = title
        self.titleImage = titleImage
    }
}
