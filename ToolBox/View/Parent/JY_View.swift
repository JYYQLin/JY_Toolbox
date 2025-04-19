//
//  JY_View.swift
//  JYYQToolBox
//
//  Created by JYYQLin on 2025/4/9.
//

import UIKit

open class JY_View: UIView {
    
    private(set) lazy var yq_scale: CGFloat = 1
      func yq_set(scale: CGFloat) {
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

extension JY_View {
    @objc dynamic open func yq_add_subviews() { }
}
