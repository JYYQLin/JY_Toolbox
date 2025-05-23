//
//  JY_Label.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/9.
//

import UIKit

open class JY_Label: UILabel {
    
    public private(set) lazy var yq_scale: CGFloat = 1
    open func yq_set(scale: CGFloat) {
         if yq_scale != scale {
             yq_scale = scale
             layoutSubviews()
         }
     }
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        yq_add_subviews()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension JY_Label {
    @objc dynamic open func yq_add_subviews() { }
}
