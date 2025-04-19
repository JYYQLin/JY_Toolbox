//
//  JY_Status_View.swift
//  JYYQToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

class JY_Status_View: JY_View {
    
    var yq_retry_request_clickBlock: (() -> Void)?
    
    private lazy var yq_status: JY_Enum_BaseController_Status = .yq_default
    
    private lazy var yq_iconName: String? = nil
    private lazy var yq_iconSize: CGSize? = nil
    
    private lazy var yq_statusText: String? = nil
    private lazy var yq_statusTextColor: UIColor? = nil
    private lazy var yq_statusFont: UIFont? = nil

    private lazy var yq_icon_imageView: UIImageView = UIImageView()

    private lazy var yq_status_label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()

    private lazy var yq_retry_button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(yq_retry_request_click), for: .touchUpInside)
        return button
    }()
}

extension JY_Status_View {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_retry_button)
        addSubview(yq_icon_imageView)
        addSubview(yq_status_label)
    }
}

extension JY_Status_View {
    @objc private func yq_retry_request_click() {
        if yq_retry_request_clickBlock != nil {
            yq_retry_request_clickBlock!()
        }
    }
    
    /**
     status: 只有在状态是 yq_no_internet || yq_no_message || yq_no_data || yq_no_comment || yq_other 才会显示 JY_Status_View
        
     iconName: 如果传入 就会显示改图片,  默认为空, 显示状态预设的图片
     iconSize:  默认为空, 会显示预设的大小, 可以传入值修改
     statusText: 默认为空, 会显示预设的文字, 可以传入值修改
     statusTextColor:  默认为空, 会显示预设的文字颜色, 可以传入值修改
     statusFont: 默认为空, 会显示预设的文字字体, 可以传入值修改
     */
    func yq_set(status: JY_Enum_BaseController_Status, iconName: String? = nil, iconSize: CGSize? = nil, statusText: String? = nil, statusTextColor: UIColor? = nil, statusFont: UIFont? = nil) {
        yq_status = status
        yq_statusText = statusText
        yq_iconName = iconName
        yq_statusFont = statusFont
        yq_statusTextColor = statusTextColor
        yq_iconSize = iconSize
        
        isHidden = status == .yq_default || status == .yq_first_request || status == .yq_data_loaded
        
        layoutSubviews()
    }
}

extension JY_Status_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
         yq_icon_imageView.frame.origin = {
            
            if yq_iconName == nil {
                yq_icon_imageView.image = UIImage(named: yq_status_imageName(status: yq_status))
            }else{
                yq_icon_imageView.image = UIImage(named: yq_iconName!)
            }
            
            if yq_iconSize == nil {
                yq_icon_imageView.frame.size = CGSize(width: 140 * yq_scale, height: 140 * yq_scale)
            }
            else{
                yq_icon_imageView.frame.size = yq_iconSize!
            }
            
            yq_icon_imageView.contentMode = .scaleAspectFit
            
            return CGPoint(x: (frame.width - yq_icon_imageView.frame.width) * 0.5, y: (frame.height * 0.5 - yq_icon_imageView.frame.height))
        }()
        
        yq_status_label.frame.origin = {
            
            if yq_statusText == nil {
                yq_status_label.text = yq_controller_status_string(status: yq_status).yq_localized(languageType: yq_localized_manager.yq_current_language)
            }else{
                yq_status_label.text = yq_statusText!
            }
            
            
            if yq_statusTextColor == nil {
                yq_status_label.textColor = UIColor.yq_status_label_textColor()
            }
            else{
                yq_status_label.textColor = yq_statusTextColor!
            }
            
            
            if yq_statusFont == nil {
                yq_status_label.font = UIFont.systemFont(ofSize: 12 * yq_scale)
            }
            else{
                yq_status_label.font = yq_statusFont!
            }
            
            yq_status_label.frame.size.width = yq_icon_imageView.frame.width + 50 * yq_scale
            yq_status_label.sizeToFit()
            
            return CGPoint(x: yq_icon_imageView.frame.midX - yq_status_label.frame.width * 0.5, y: yq_icon_imageView.frame.maxY + 8 * yq_scale)
        }()
        
        yq_retry_button.frame = {
           
            let x = yq_icon_imageView.frame.minX <= yq_status_label.frame.minX ? yq_icon_imageView.frame.minX : yq_status_label.frame.minX
            
            let width = (yq_icon_imageView.frame.width >= yq_status_label.frame.width ? yq_icon_imageView.frame.width : yq_status_label.frame.width)
            
            let height = yq_status_label.frame.maxY - yq_icon_imageView.frame.minY
            
            return CGRect(x: x, y: yq_icon_imageView.frame.minY, width: width, height: height)
        }()
    }
}

extension JY_Status_View {
    func yq_status_imageName(status: JY_Enum_BaseController_Status) -> String {
        if status == .yq_no_data {
            return "yq_no_data_icon"
        }
        
        else if status == .yq_no_internet {
            return "yq_no_internet_icon"
        }
        
        else if status == .yq_no_message {
            return "yq_no_message_icon"
        }
        
        else if status == .yq_no_comment {
            return "yq_no_comment_icon"
        }
        
        else {
            return "yq_status_imageName_icon"
        }
    }
    
    
    public func yq_controller_status_string(status: JY_Enum_BaseController_Status) -> String {
        
        if status == .yq_no_data {
            return "yq_no_data_string"
        }
        
        else if status == .yq_no_internet {
            return "yq_no_internet_string"
        }
        
        else if status == .yq_data_loaded {
            return "yq_data_loaded_string"
        }
        
        else if status == .yq_no_message {
            return "yq_no_message_string"
        }
        
        else if status == .yq_no_comment {
            return "yq_no_comment_string"
        }
        
        else if status == .yq_first_request {
            return "yq_first_request_string"
        }
        
        else {
            return "yq_default_string"
        }
    }
}
