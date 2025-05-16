//
//  JY_TableView.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/28.
//

import UIKit

class JY_TableView: UITableView {
   
    public private(set) lazy var yq_scale: CGFloat = 1
    open func yq_set(scale: CGFloat) {
         if yq_scale != scale {
             yq_scale = scale
             layoutSubviews()
         }
     }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = UIColor.clear
        contentInsetAdjustmentBehavior = .never
        automaticallyAdjustsScrollIndicatorInsets = false
        
        yq_add_subviews()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JY_TableView {
    @objc dynamic open func yq_add_subviews() { }
}

