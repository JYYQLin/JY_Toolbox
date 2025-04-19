//
//  JY_Base_Loading_View.swift
//  JYYQToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

open class JY_Base_Loading_View: JY_View {
        
    private lazy var yq_loading_view: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
}

extension JY_Base_Loading_View {
    open override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_loading_view)
    }
}

extension JY_Base_Loading_View {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.yq_controller_loading_bgColor()
        
        yq_loading_view.frame.size = CGSize(width: 87 * yq_scale, height: 87 * yq_scale)
        
        yq_loading_view.frame.origin = CGPoint(x: (frame.width - yq_loading_view.frame.width) * 0.5, y: (frame.height - yq_loading_view.frame.height) * 0.5)
        
        yq_loading_view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        yq_loading_view.transform = CGAffineTransform(scaleX: 1.5 * yq_scale, y: 1.5 * yq_scale)
        
        yq_loading_view.color = UIColor.yq_controller_loading_color()
    }
    
    public func yq_show_loading() {
        yq_loading_view.startAnimating()
        isHidden = false
    }
    
    public func yq_hidden_loading() {
        isHidden = true
        yq_loading_view.stopAnimating()
    }
}
