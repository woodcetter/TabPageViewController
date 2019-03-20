//
//  TabBarView.swift
//  TabPageViewController
//
//  Created by sykim on 20/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit

protocol TabBarViewDelegate {
    func didTapBarItem(item: ContainTabBar)
}

class TabBarView: UIView {

    struct Metric {
        static let tabBarScrollViewTop = CGFloat(0)
        static let tabBarScrollViewLeft = CGFloat(0)

        static let underScoreHeight = CGFloat(10)
    }
    
    // MARK: - UI Properties
    lazy var tabBarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TabBarCell.self, forCellWithReuseIdentifier: self.cellId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    var underScoreView: UIView = UIView()
    
    // MARK: - Properties
    var delegate: TabBarViewDelegate?
    fileprivate var items: [TabBarViewModel] = []
    fileprivate let cellId: String = "TabBarCell"
    fileprivate var tabSize: CGSize = .zero

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.underScoreView.backgroundColor = .green
        
        self.addSubview(self.underScoreView)
        self.addSubview(self.tabBarCollectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tabBarCollectionView.top = Metric.tabBarScrollViewTop
        self.tabBarCollectionView.left = self.left
        self.tabBarCollectionView.width = self.width
        self.tabBarCollectionView.height = self.height
        
        self.underScoreView.top = self.tabBarCollectionView.height - Metric.underScoreHeight
        self.underScoreView.left = self.left
        self.underScoreView.width = self.tabSize.width
        self.underScoreView.height = Metric.underScoreHeight
    }
    
    func configure(items: [TabBarViewModel]) {
        self.items = items
        self.setMaxSize()
        self.initTabBarButton()
    }
    
    func setMaxSize() {
        let _item = self.items.max { item1, item2 in
            item1.title.count < item2.title.count
        }!
        self.tabSize = TabBarCell.getSize(title: _item.title, height: self.height)
        self.layoutSubviews()
    }
    
    fileprivate func initTabBarButton() {
        DispatchQueue.main.async {
            self.tabBarCollectionView.reloadData()
        }
    }
    
}

extension TabBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabBarCell
        cell.configure(item: self.items[indexPath.item])
        return cell
    }
}

extension TabBarView: UICollectionViewDelegateFlowLayout {
    // cell size 조절
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.tabSize
    }
    
    // cell 내부 여백 추가
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero // UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
//    // cell 과 cell 행 사이의 최소간격을 설정
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    // cell 과 cell 사이의 최소간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
