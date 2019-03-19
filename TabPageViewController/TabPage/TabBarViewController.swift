//
//  TabBarViewController.swift
//  TabPageViewController
//
//  Created by sykim on 19/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit

protocol TabBarViewControllerDelegate {
    func didTapBarItem(item: ContainTabBar)
}

class TabBarViewController: UIViewController {
    
    struct Metric {
        static let tabBarScrollViewTop = CGFloat(0)
        static let tabBarScrollViewLeft = CGFloat(0)
    }
    
    // MARK: - UI Properties
    fileprivate let tabBarScrollView = UIScrollView()
    fileprivate var tabBarButtons: [UIButton] = []
    
    // MARK: - Properties
    var delegate: TabBarViewControllerDelegate?
    var item: TabBarViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarScrollView.delegate = self
        self.view.addSubview(self.tabBarScrollView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tabBarScrollView.snp.makeConstraints { make in
//            make.top.equalTo(self.topLayout)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(Metric.tabBarScrollViewHeight)
            make.edges.equalToSuperview()
        }
    }
    
    func configure(item: TabBarViewModel) {
        self.item = item
        self.initTabBarButton()
    }
    
    fileprivate func initTabBarButton() {
        for (index ,title) in self.item.titles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.tema, for: .selected)
//            button.contentHorizontalAlignment = .center
//            button.contentVerticalAlignment = .center
            button.addTarget(self, action: #selector(tabBarButtonDidTap), for: .touchUpInside)
            
            self.tabBarButtons.append(button)
            self.tabBarScrollView.addSubview(self.tabBarButtons[index])
            
            self.tabBarButtons[index].top = Metric.tabBarScrollViewTop
            self.tabBarButtons[index].left = index > 0 ? self.tabBarButtons[index - 1].right : Metric.tabBarScrollViewLeft
            self.tabBarButtons[index].width = self.view.width / CGFloat(self.item.titles.count)
            self.tabBarButtons[index].height = self.view.height
        }
    }

    // MARK: - UI Action
    @objc func tabBarButtonDidTap(_ sender: UIButton) {
        self.delegate?.didTapBarItem(item: self.item)
    }
}

extension TabBarViewController: UIScrollViewDelegate {
    
}
