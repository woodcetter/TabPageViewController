//
//  TabBarCollectionViewCell.swift
//  TabPageViewController
//
//  Created by sykim on 20/03/2019.
//  Copyright © 2019 sykim. All rights reserved.
//

import UIKit

class TabBarCell: UICollectionViewCell {
    
    struct Metric {
        static let cellTop = CGFloat(0)
        static let cellLeft = CGFloat(10)
        static let cellRight = CGFloat(10)
    }
    
    struct Font {
        static let titleLabelFont = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    // MARK: - UI Properties
    fileprivate let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.titleLabel.font = Font.titleLabelFont
        self.titleLabel.textAlignment = .center
//        self.titleLabel.backgroundColor = .yellow
        
//        self.contentView.backgroundColor = .green
        self.contentView.addSubview(self.titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.layer.addBorder([.right], color: .black)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.top = Metric.cellTop
        self.titleLabel.left = Metric.cellLeft
//        self.titleLabel.sizeToFit() // 라벨의 text 만큼 fit하게 조절
        self.titleLabel.width = self.contentView.width - (Metric.cellLeft + Metric.cellRight)
        self.titleLabel.height = self.contentView.height
    }
    
    func configure(item: TabBarViewModel) {
        self.titleLabel.text = item.title
    }
    
    /**
     Cell 사이즈를 조절한다.
     
     - Parameters:
        - title: Label에 사용할 문자
        - height: Cell 높이
     
     - Returns: CGSize
     */
    class func getSize(title: String, height: CGFloat) -> CGSize {
        let label = UILabel()
        label.text = title
        label.font = Font.titleLabelFont
        
        let width = min(label.intrinsicContentSize.width + Metric.cellLeft + Metric.cellRight, UIScreen.main.bounds.width)
        let size = CGSize(width: ceil(width), height: height)
        
//        if !title.isEmpty {
//            let rect = title.boundingRect(with: size,
//                                          options: [.usesLineFragmentOrigin, .usesFontLeading],
//                                          attributes: [.font : Font.titleLabelFont],
//                                          context: nil)
//           size = CGSize(width: rect.width, height: ceil(rect.height))
//        }
//
        return size
    }
    
}
