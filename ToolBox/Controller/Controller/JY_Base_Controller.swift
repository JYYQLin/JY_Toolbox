//
//  JY_Base_Controller.swift
//  JYYQToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

open class JY_Base_Controller: UIViewController {

    //  状态栏颜色
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }

    //  控制器状态
    public lazy var yq_controller_status: JY_Enum_BaseController_Status = .yq_default {
        didSet {
            yq_controller_status_change()
        }
    }

    public lazy var yq_scale: CGFloat = 1.0
    public lazy var yq_is_push: Bool = true
    public lazy var yq_is_tabBar_child: Bool = false
    
    public lazy var yq_content_view: UIView = UIView()
    
    public lazy var yq_background_content_view: UIView = UIView()
    
    //  用于解决,左滑返回于scrollView等控件左右滑动冲突,牺牲左侧宽度10的所有事件
    private(set) lazy var yq_left_tap_view: UIView = UIView()
    
    private(set) lazy var yq_request_loading_view: JY_Base_Loading_View = JY_Base_Loading_View()
    
    private(set) lazy var yq_status_view: JY_Status_View = {
        let view = JY_Status_View()
        
        view.yq_retry_request_clickBlock = { [weak self] in
            self?.yq_retry_request_click()
        }
        
        return view
    }()
    
    deinit {
        print(String(format: "%@", self) + "被销毁了")
    }
}

extension JY_Base_Controller {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        yq_setInterface()
        yq_setNavigationBar()
        
        yq_controller_status = .yq_default

        yq_controller_manager.yq_add_log(controllerName: "\(self)", status: "viewDidLoad")
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        yq_setSubviewsFrame()
        
        yq_controller_manager.yq_add_log(controllerName: "\(self)", status: "viewWillLayoutSubviews")
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        yq_controller_manager.yq_add_log(controllerName: "\(self)", status: "viewWillDisappear")
    }
}

extension JY_Base_Controller {
    
    @objc dynamic open func yq_retry_request_click() {
        yq_controller_status = .yq_first_request
    }
}

extension JY_Base_Controller {
    @objc dynamic open func yq_setInterface() {
        
        view.addSubview(yq_background_content_view)
        view.addSubview(yq_status_view)
        
        view.addSubview(yq_request_loading_view)
        view.addSubview(yq_content_view)
    }
    
    @objc dynamic open func yq_setNavigationBar() {
        
        view.addSubview(yq_left_tap_view)
    }
    
    @objc dynamic open func yq_setSubviewsFrame() {
        
        let scale = view.frame.yq_scale_to_width(originalWidth: 375)
        yq_scale = scale
        
        yq_background_content_view.frame = view.bounds
        yq_content_view.frame = view.bounds
        
        yq_request_loading_view.frame = view.bounds
        yq_request_loading_view.yq_set(scale: scale)
        
        yq_status_view.frame = view.bounds
        yq_status_view.yq_set(scale: scale)
        
        yq_background_content_view.backgroundColor = JY_Base_Controller.yq_background_color()
        
        yq_left_tap_view.frame = CGRect(x: 0, y: yq_current_device.yq_navigationBar_maxY(), width: 15 * scale, height: view.frame.height - yq_current_device.yq_navigationBar_maxY())
    }
}

extension JY_Base_Controller {
    private func yq_show_request_loading() {
        yq_content_view.isHidden = true
        yq_request_loading_view.yq_show_loading()
    }
    
    private func yq_show_contentView() {
        yq_request_loading_view.yq_hidden_loading()
        yq_content_view.isHidden = false
    }
}

extension JY_Base_Controller {
    private func yq_controller_status_change(iconName: String? = nil, iconSize: CGSize? = nil, statusText: String? = nil, statusTextColor: UIColor? = nil, statusFont: UIFont? = nil) {
        
        yq_status_view.yq_set(status: yq_controller_status, iconName: iconName, iconSize: iconSize, statusText: statusText,  statusTextColor: statusTextColor, statusFont: statusFont)
        
        if yq_controller_status == JY_Enum_BaseController_Status.yq_first_request {
            yq_show_request_loading()
            
        }else if yq_controller_status == .yq_data_loaded || yq_controller_status == .yq_default {
            yq_show_contentView()
            
        }else if yq_controller_status == .yq_no_data || yq_controller_status == .yq_no_internet || yq_controller_status == .yq_no_message || yq_controller_status == .yq_no_comment {
            
            yq_request_loading_view.yq_hidden_loading()
            yq_content_view.isHidden = true
            
        }else if yq_controller_status == .yq_other {
            
            yq_request_loading_view.yq_hidden_loading()
            yq_content_view.isHidden = true
        }
    }
    
    public func yq_controller_status_other(iconName: String? = nil, iconSize: CGSize? = nil, statusText: String? = nil, statusTextColor: UIColor? = nil, statusFont: UIFont? = nil) {
        
        yq_controller_status = .yq_other
        yq_controller_status_change(iconName: iconName, iconSize: iconSize, statusText: statusText, statusTextColor: statusTextColor, statusFont: statusFont)
    }
}

public extension JY_Base_Controller {
    static func yq_ID() -> String {
        return "\(self)"
    }
    
    static func yq_background_color() -> UIColor? {
        return UIColor.yq_controller_bgColor()
    }
}
