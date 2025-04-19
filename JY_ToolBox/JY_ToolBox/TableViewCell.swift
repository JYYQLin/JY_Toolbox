//
//  TableViewCell.swift
//  JY_ToolBox
//
//  Created by 林君扬 on 2025/4/19.
//

import UIKit

class TableViewCell: JY_Base_TableViewCell {
    
    private lazy var yq_title: String = ""
    
    private lazy var yq_title_label: JY_Label = JY_Label()
}

extension TableViewCell {
    func yq_set(title: String) {
        if title != yq_title {
            yq_title = title
            layoutSubviews()
        }
    }
}

extension TableViewCell {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_title_label)
    }
}

extension TableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_title_label.frame.origin = {
            yq_title_label.text = yq_title
            yq_title_label.font = UIFont.systemFont(ofSize: 15)
            yq_title_label.textColor = UIColor.yq_color(colorString: "#212121")
            yq_title_label.sizeToFit()
            return CGPoint(x: 15, y: (contentView.frame.height - yq_title_label.frame.height) * 0.5)
        }()
    }
}
