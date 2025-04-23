//
//  JY_TextField.swift
//  JY_ToolBox
//
//  Created by JYTools on 2024/10/13.
//

import UIKit

open class JY_TextField: UITextField {
    
    public private(set) lazy var yq_scale: CGFloat = 1
    open func yq_set(scale: CGFloat) {
         if yq_scale != scale {
             yq_scale = scale
             layoutSubviews()
         }
     }
    
    public var yq_placeholder_color: UIColor? {
        didSet{
            yq_change_placeholder();
        }
    }
    
    public var yq_placeholder_font: UIFont? {
        didSet{
            yq_change_placeholder();
        }
    }
    
    public override var placeholder: String? {
        didSet{
            let p = placeholder
            yq_change_placeholder()
            super.placeholder = p
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

extension JY_TextField {
    private func yq_change_placeholder() {
        let ivar = class_getInstanceVariable(object_getClass(UITextField()), "_placeholderLabel")
        let placeholderLabel  = object_getIvar(self, ivar!) as? UILabel
        placeholderLabel?.textColor = yq_placeholder_color
        placeholderLabel?.font = yq_placeholder_font
    }
}

extension JY_TextField {
    @objc dynamic open func yq_add_subviews() { }
}
