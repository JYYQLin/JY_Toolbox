//
//  JY_CollectionView.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import UIKit

class JY_CollectionView: UICollectionView {

    public private(set) lazy var yq_scale: CGFloat = 1
    open func yq_set(scale: CGFloat) {
         if yq_scale != scale {
             yq_scale = scale
             layoutSubviews()
         }
     }
    
    public override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
 
        backgroundColor = UIColor.clear
        contentInsetAdjustmentBehavior = .never
        automaticallyAdjustsScrollIndicatorInsets = false
        
        yq_add_subviews()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JY_CollectionView {
    @objc dynamic open func yq_add_subviews() { }
}
