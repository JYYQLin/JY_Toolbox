//
//  JY_Loading_HUD_Manager.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/27.
//

import UIKit

open class JY_Loading_HUD_Manager {
    // 定义单例实例
    public static let yq_shared = JY_Loading_HUD_Manager()
    // 私有化初始化方法，防止外部创建新的实例
    private init() { }
    
    private(set) lazy var yq_timeout: Int = 60 * 5
    
    deinit {
        yq_remove_time_notification()
    }
    
    private(set) lazy var yq_loading_HUD_array: [(showView: UIView, LoadingHUD: JY_Loading_HUD)] = [(showView: UIView, LoadingHUD: JY_Loading_HUD)]()
    
}

public extension JY_Loading_HUD_Manager {
    func yq_set(timeOut: Int) {
        yq_timeout = timeOut
    }
}

public extension JY_Loading_HUD_Manager {
    func yq_add_time_notification() {
        JY_Timer_Manager.yq_add_timer_fired_change_notification(self, selector: #selector(yq_auto_hidden_loading_HUD))
    }
    
    func yq_remove_time_notification() {
        JY_Timer_Manager.yq_remove_timer_fired_change_notification(self)
        NotificationCenter.default.removeObserver(self)
    }
}

public extension JY_Loading_HUD_Manager {
    
    func yq_add_loading_HUD(_ HUD: (showView: UIView, LoadingHUD: JY_Loading_HUD)) {
        
        var isExist = false
        for oldHUD in yq_loading_HUD_array {
            //  如果新要显示的hud已经存在了, 并且显示在的View也是同一个,则不添加
            if HUD.showView == oldHUD.showView && oldHUD.LoadingHUD.yq_task_Name == HUD.LoadingHUD.yq_task_Name {
                isExist = true
                break
            }
        }
        
        if isExist == false {
            yq_loading_HUD_array.append(HUD)
            yq_add_time_notification()
        }
        
        yq_show_loading()
    }
    
    private func yq_show_loading() {
        
        if let HUD = yq_loading_HUD_array.first {
            HUD.showView.addSubview(HUD.LoadingHUD)
            HUD.LoadingHUD.frame = HUD.showView.bounds
            HUD.LoadingHUD.layoutSubviews()
        }
        
//        guard let showView = UIWindow.yq_first_window() else {
//            return
//        }
//
//        let scale = showView.frame.width.yq_scale_to(originalWidth: 375)
//
//        if let HUD = yq_loading_HUD_array.first {
//            showView.addSubview(HUD.LoadingHUD)
//            HUD.LoadingHUD.frame = showView.bounds
//            HUD.LoadingHUD.layoutSubviews()
//        }
        
    }
    
    func yq_hidden_loading_HUD(taskName: String) {
        
        for (index, HUD) in yq_loading_HUD_array.enumerated() {
            if HUD.LoadingHUD.yq_task_Name == taskName {
                HUD.LoadingHUD.removeFromSuperview()
                yq_loading_HUD_array.remove(at: index)
            }
        }
        
        yq_show_loading()
        
        //  表示没有loading任务, 则隐藏loadingHUD
        if yq_loading_HUD_array.count == 0 {
            yq_remove_time_notification()
        }
    }
    
    func yq_hidden_all_HUD() {
        for (index, HUD) in yq_loading_HUD_array.enumerated() {
                HUD.LoadingHUD.removeFromSuperview()
                yq_loading_HUD_array.remove(at: index)
        }
    }
    
    @objc private func yq_auto_hidden_loading_HUD() {
        
//        for HUD in yq_loading_HUD_array {
//
//            if ((HUD.LoadingHUD.yq_creat_time + yq_timeout) < JY_Date_Tool.yq_get_current_timeInterval()) {
//                yq_hidden_loading_HUD(taskName: HUD.LoadingHUD.yq_task_Name)
//            }
//
//        }
    }
}
