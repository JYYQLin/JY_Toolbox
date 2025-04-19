//
//  JY_Extension_Example_View.swift
//  JY_ToolBox
//
//  Created by 林君扬 on 2025/4/19.
//

import UIKit

class JY_Extension_Int_Example_View: JY_View {
    private lazy var yq_title_label: JY_Label = JY_Label()
    private lazy var yq_textField: JY_TextField = JY_TextField()
    private lazy var yq_value_label: JY_Label = JY_Label()
    private lazy var yq_button: JY_Button = JY_Button()
    
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_title_label)
        addSubview(yq_textField)
        addSubview(yq_value_label)
    }
    
    func yq_set(title: String, value: String) {
        yq_title_label.text = title
        yq_value_label.text = value
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_title_label.frame.origin = {
            yq_title_label.font = UIFont.systemFont(ofSize: 15)
            yq_title_label.textColor = UIColor.yq_color(colorString: "#212121")
            yq_title_label.sizeToFit()
            return CGPoint(x: 15, y: 0)
        }()
        
        yq_textField.frame.origin = {
            let font = UIFont.systemFont(ofSize: 12)
            yq_textField.font = font
            yq_textField.yq_placeholder_font = font
            yq_textField.textColor = UIColor.yq_color(colorString: "#3377FF")
            yq_textField.yq_placeholder_color = UIColor.yq_color(colorString: "#BDBDBD")
            yq_textField.frame.size = CGSize(width: frame.width * 0.5 - 22, height: 20)
            return CGPoint(x: 22, y: yq_title_label.frame.maxY + 5)
        }()
        
        yq_button.frame.origin = {
            yq_button.frame.size = CGSize(width: 35, height: 20)
            yq_button.setTitle("调用方法", for: .normal)
            yq_button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            return CGPoint(x: yq_textField.frame.maxX + 15, y: yq_textField.frame.midY - yq_button.frame.height * 0.5)
        }()
    }
}
