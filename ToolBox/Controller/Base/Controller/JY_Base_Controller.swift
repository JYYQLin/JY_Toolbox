//
//  JY_Base_Controller.swift
//  JY_Treasure_Box
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

    public private(set) lazy var yq_scale: CGFloat = 1.0
    open func yq_set(scale: CGFloat) {
         if yq_scale != scale {
             yq_scale = scale
             yq_layout_subviews_frame()
         }
     }
    
    public lazy var yq_is_push: Bool = true
    
    public lazy var yq_content_view: JY_View = JY_View()
    
    public lazy var yq_background_content_view: JY_View = JY_View()
    
    //  用于解决,左滑返回于scrollView等控件左右滑动冲突,牺牲左侧宽度10的所有事件
    private(set) lazy var yq_left_tap_view: JY_View = JY_View()
    
    public lazy var yq_request_loading_view: JY_View = JY_View()
    
    private(set) lazy var yq_status_view: JY_View = JY_View()
    
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
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        yq_setSubviewsFrame()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
}

extension JY_Base_Controller {
    
    @objc dynamic open func yq_retry_request_click() {
        yq_controller_status = .yq_loading
    }
}

extension JY_Base_Controller {
    @objc dynamic open func yq_setInterface() {
        
        view.addSubview(yq_background_content_view)
        yq_background_content_view.isUserInteractionEnabled = false
        
        view.addSubview(yq_status_view)
        
        view.addSubview(yq_request_loading_view)
        yq_request_loading_view.isUserInteractionEnabled = false
        
        view.addSubview(yq_content_view)
    }
    
    public func yq_content_addSubview(_ view: UIView) {
        yq_content_view.addSubview(view)
    }
    
    public func yq_request_loading_addSubview(_ view: UIView) {
        for subView in yq_request_loading_view.subviews {
            subView.removeFromSuperview()
        }
        
        yq_request_loading_view.addSubview(view)
    }
    
    public func yq_status_addSubview(_ view: UIView) {
        for subView in yq_status_view.subviews {
            subView.removeFromSuperview()
        }
        
        yq_status_view.addSubview(view)
    }
}

extension JY_Base_Controller {
    @objc dynamic open func yq_setNavigationBar() {
        
        view.addSubview(yq_left_tap_view)
    }
    
    @objc dynamic open func yq_setSubviewsFrame() {
        
        let scale = view.frame.yq_scale_to_width(originalWidth: 375)
        yq_set(scale: scale)
        
        yq_layout_subviews_frame()
    }
    
    private func yq_layout_subviews_frame() {
        yq_background_content_view.frame = view.bounds
        yq_content_view.frame = view.bounds
        
        yq_request_loading_view.frame = view.bounds
        yq_request_loading_view.yq_set(scale: yq_scale)
        
        yq_status_view.frame = view.bounds
        yq_status_view.yq_set(scale: yq_scale)
                
        yq_left_tap_view.frame = CGRect(x: 0, y: yq_current_device.yq_navigationBar_maxY(), width: 15 * yq_scale, height: view.frame.height - yq_current_device.yq_navigationBar_maxY())
    }
}

extension JY_Base_Controller {
    private func yq_controller_status_change() {
        
        if yq_controller_status == JY_Enum_BaseController_Status.yq_loading {
            
            yq_show_loadingView()
        }else if yq_controller_status == .yq_data_loaded || yq_controller_status == .yq_default {
            
            yq_show_contentView()
        }else if yq_controller_status == .yq_show_status {
            
            yq_show_statusView()
        }
    }
}

extension JY_Base_Controller {
    private func yq_show_loadingView() {
        yq_content_view.isHidden = true
        yq_status_view.isHidden = true
        yq_request_loading_view.isHidden = false
    }
    
    private func yq_show_contentView() {
        yq_request_loading_view.isHidden = true
        yq_content_view.isHidden = false
        yq_status_view.isHidden = true
    }
    
    private func yq_show_statusView() {
        yq_content_view.isHidden = true
        yq_status_view.isHidden = false
        yq_request_loading_view.isHidden = true
    }
}

public extension JY_Base_Controller {
    class func yq_ID() -> String {
        let name = ("\(self)" + "\(#function)")
        return name.yq_md5()
    }
}

//public extension UIViewController {
//    
//    @objc func yq_force_orientation_portrait() {
//        let appdelegate = UIApplication.shared.delegate as? AppDelegate
//        
//        if appdelegate?.yq_allow_rotation == false {
//            return
//        }
//        
//        appdelegate?.yq_allow_rotation = false
//        
//        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//        
//        UIViewController.attemptRotationToDeviceOrientation()
//    }
//    
//    @objc func yq_force_orientation_landscape() {
//        let appdelegate = UIApplication.shared.delegate as? AppDelegate
//        
//        if appdelegate?.yq_allow_rotation == true {
//            return
//        }
//        
//        appdelegate?.yq_allow_rotation = true
//        
//        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//        
//        UIViewController.attemptRotationToDeviceOrientation()
//    }
//}
