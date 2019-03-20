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
        
        static let tabBarScrollViewHeight = CGFloat(80)
    }
    
    // MARK: UI Properties
    fileprivate let tabBarView = TabBarView()
    fileprivate let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    // MARK: Properties
    lazy var items: [TabBarViewModel] = {
        var _items: [TabBarViewModel] = []
        for i in 0 ..< MainColor.count {
            _items.append(TabBarViewModel(title: i == 5 ? "\(i)번 타이틀" : "\(i)번"))
        }
        return _items
    }()
    
    lazy var viewControllers: [UIViewController] = {
        var _viewControllers: [UIViewController] = []
        for i in 0 ..< MainColor.count {
            let viewController = BodyViewController()
            viewController.view.tag = i
            viewController.view.backgroundColor = MainColor(rawValue: i)!.color
            _viewControllers.append(viewController)
        }
        return _viewControllers
    }()
    
    var currentPageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        self.tabBarView.delegate = self
        
        self.pageViewController.dataSource = self
        for subView in self.pageViewController.view.subviews {
            if let scrollView = subView as? UIScrollView {
             scrollView.delegate = self
            }
        }
        self.pageViewController.setViewControllers([self.viewControllers.first] as? [UIViewController], direction: .forward, animated: true, completion: nil)

        self.view.addSubview(self.tabBarView)
//        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tabBarView.snp.makeConstraints { make in
            make.top.equalTo(self.topLayout)
            make.left.right.equalToSuperview()
            make.height.equalTo(Metric.tabBarScrollViewHeight)
        }
        
        self.pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(self.tabBarView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.bottomLayout)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarView.configure(items: items)
    }
    
    enum MainColor: Int {
        case red = 0
        case orange
        case yellow
        case green
        case blue
        case navy
        case purple
        
        static var count: Int {
            return MainColor.purple.rawValue + 1
        }
        
        var color: UIColor {
            var _color: UIColor!
            switch self {
            case .red: _color = .red
            case .orange: _color = .orange
            case .yellow: _color = .yellow
            case .green: _color = .green
            case .blue: _color = .blue
            case .navy: _color = .navy
            case .purple: _color = .purple
            }
            
            return _color
        }
    }
}

extension TabPageViewController: TabBarViewDelegate {
    func didTapBarItem(item: ContainTabBar) {
        
    }
}

extension TabPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point: CGPoint = scrollView.contentOffset // 컨텐츠 전체 크기 (ex 375, 0)
        print("\(point)")
        let width: CGFloat = self.tabBarView.underScoreView.width
        let magnification: CGFloat = (scrollView.width / width) // 배율 (ex 375 / 80 = 4.6875)
        var x: CGFloat = point.x - scrollView.width // 스크롤을 이동한 크기 (ex 425 - 375 = 50)
        print("x: \(x)")
        if point.x == scrollView.width { // 스크롤 중지 상태
            x = CGFloat(self.currentPageIndex) * width // 현 페이지를 기준으로 이동한다.
            print("result: \(x)\n")
        } else if point.x > scrollView.width { // next
            x /= magnification // 이동한 스크롤 크기에서 underScoreView.width 의 비율만큼 계산 (ex 50 / 4.6875 = 10.6)
            print("result: \(x)\n")
        } else { // prev
            x = point.x + scrollView.width
            x /= magnification // 이동한 스크롤 크기에서 underScoreView.width 의 비율만큼 계산 (ex 50 / 4.6875 = 10.6)
            print("result: \(x)\n")
        }
        
        print(point)
        UIView.animate(withDuration: 0.0, animations: {
            self.tabBarView.underScoreView.frame = CGRect(x: x,
                                                          y: self.tabBarView.underScoreView.y,
                                                          width: self.tabBarView.underScoreView.width,
                                                          height: self.tabBarView.underScoreView.height)
            self.tabBarView.underScoreView.layoutIfNeeded()
        })
    }
}

extension TabPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let _viewController = viewController as! BodyViewController
        self.currentPageIndex = _viewController.view.tag
        if self.currentPageIndex > 0 {
            return self.viewControllers[self.currentPageIndex - 1]
        } else { return nil }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let _viewController = viewController as! BodyViewController
        self.currentPageIndex = _viewController.view.tag
        if let lastIndex = self.viewControllers.last?.view.tag, self.currentPageIndex < lastIndex  {
            return self.viewControllers[self.currentPageIndex + 1]
        } else { return nil }
    }
}
