//
//  TabPageViewController.swift
//  TabPageViewController
//
//  Created by sykim on 19/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit

class TabPageViewController: UIViewController {
    
    struct Metric {
        static let tabBarScrollViewLeft = CGFloat(0)
        static let tabBarScrollViewHeight = CGFloat(50)
    }
    
    // MARK: UI Properties
    fileprivate let tabBarViewController = TabBarViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = TabBarViewModel(titles: ["1번버튼", "2번버튼", "3번버튼", "4번버튼", "5번버튼", "6번버튼", "7번버튼", "8번버튼"])
        self.tabBarViewController.delegate = self
        self.tabBarViewController.configure(item: item)
        
        self.view.addSubview(self.tabBarViewController.view)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tabBarViewController.view.snp.makeConstraints { make in
            make.top.equalTo(self.topLayout)
            make.left.right.equalToSuperview()
            make.height.equalTo(Metric.tabBarScrollViewHeight)
        }
    }

}

extension TabPageViewController: TabBarViewControllerDelegate {
    func didTapBarItem(item: ContainTabBar) {
        
    }
}
