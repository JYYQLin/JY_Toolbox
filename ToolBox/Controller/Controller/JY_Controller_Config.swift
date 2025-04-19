//
//  JY_Controller_Config.swift
//  JYYQToolBox
//
//  Created by JYYQLin on 2024/12/30.
//

import UIKit

extension UIColor {
    //  控制器背景色
    static func yq_controller_bgColor() -> UIColor {
        return UIColor(named: "viewBgColor") ?? UIColor(named: "yq_baseController_bgColor") ?? UIColor.yq_color(red: 248, green: 248, blue: 248)
    }
    
    
    
    //  MARK: LoadingView
    //  Loading背景颜色
    static func yq_controller_loading_bgColor() -> UIColor {
        return UIColor(named: "loadingBgColor") ?? UIColor(named: "yq_controller_loadingView_bgColor") ?? UIColor.yq_color(red: 28, green: 28, blue: 28).withAlphaComponent(0.45)
    }
    
    //  Loading颜色
    static func yq_controller_loading_color() -> UIColor? {
        return UIColor(named: "loadingColor") ?? UIColor(named: "yq_controller_loadingView_color") ?? UIColor(named: "AccentColor")
    }
    
    
    
    //  MARK: StatusLabel
    static func yq_status_label_textColor() -> UIColor {
        return UIColor(named: "viewStatusTextColor") ?? UIColor(named: "yq_base_status_label_textColor") ?? UIColor.yq_color(red: 250, green: 250, blue: 250).withAlphaComponent(0.75)
    }
}


extension UIImage {
    static func yq_controller_header_image() -> UIImage? {
        return UIImage(named: "yq_controller_header_image")
    }
}
