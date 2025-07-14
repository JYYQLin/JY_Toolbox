//
//  JY_Tip_HUD_Manager.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/27.
//

import UIKit

open class JY_Tip_HUD_Manager {
    // 定义单例实例
    public static let yq_shared = JY_Tip_HUD_Manager()
    // 私有化初始化方法，防止外部创建新的实例
    private init() { }
    
    deinit {
        yq_remove_time_notification()
    }
    
    /** 是否过滤重复的提示 */
   open lazy var yq_is_filter_duplicates: Bool = false
    
    private(set) lazy var yq_tip_HUD_array: [JY_Tip_HUD] = [JY_Tip_HUD]()
    
    private(set) lazy var yq_is_show: Bool = false
}

extension JY_Tip_HUD_Manager {
    func yq_add_time_notification() {
//        JY_Timer_Manager.yq_add_timer_fired_change_notification(self, selector: #selector(yq_auto_hidden_loading_HUD))
    }
    
    func yq_remove_time_notification() {
        JY_Timer_Manager.yq_remove_timer_fired_change_notification(self)
        NotificationCenter.default.removeObserver(self)
    }
}

extension JY_Tip_HUD_Manager {
    public func yq_add_tip_HUD(_ HUD: JY_Tip_HUD) {
        
        var isExist = false
        
        if yq_is_filter_duplicates == true {
            
            for oldHUD in yq_tip_HUD_array {
                //  如果新要显示的hud已经存在了, 并且显示在的View也是同一个,则不添加
                if oldHUD.yq_task_Name == HUD.yq_task_Name {
                    isExist = true
                    break
                }
            }
        }

        
        if isExist == false {
            yq_tip_HUD_array.append(HUD)
            yq_add_time_notification()
        }
        
        yq_show_tip()
    }
    
    @objc func yq_show_tip() {
        
        if yq_is_show == true {
            return
        }
        
        guard let showView = UIWindow.yq_first_window() else {
            return
        }
        
        let scale = showView.frame.width.yq_scale_to(originalWidth: 375)
        
        if let HUD = yq_tip_HUD_array.first {
            showView.addSubview(HUD)
            HUD.frame.size = HUD.yq_size(scale: scale)
            HUD.frame.origin = CGPoint(x: (showView.frame.width - HUD.frame.width) * 0.5, y: yq_current_device.yq_statusBar_height())
            yq_is_show = true
            HUD.performCustomAnimation { [weak self] in
                self?.yq_hidden_tip()
            }
        }
    }
    
    func yq_hidden_tip() {
        
        if let HUD = yq_tip_HUD_array.first {
            HUD.removeFromSuperview()
            yq_tip_HUD_array.removeFirst()
            yq_is_show = false
        }
        
        yq_show_tip()
        
        if yq_tip_HUD_array.count == 0 {
            yq_remove_time_notification()
        }
    }
}

//extension JY_Tip_HUD_Manager: CAAnimationDelegate {
//    
//}

//}
