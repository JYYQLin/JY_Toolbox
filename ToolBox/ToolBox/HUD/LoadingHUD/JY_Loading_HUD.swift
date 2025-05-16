//
//  JY_Loading_HUD.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/26.
//

import UIKit

open class JY_Loading_HUD: JY_View {
    
    lazy var yq_HUD_content_view: JY_View = JY_View()
    
    private(set) lazy var yq_tap_count: Int = 0
    
    lazy var yq_task_Name: String = ""
    lazy var yq_creat_time: Int = 0
}

public extension JY_Loading_HUD {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        self.addSubview(yq_HUD_content_view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(yq_tap_add_count))
        yq_HUD_content_view.addGestureRecognizer(tap)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_HUD_content_view.frame = self.bounds
    }
}

public extension JY_Loading_HUD {
    //  提供一个方法 强制关闭HUD, 防止死机状态
    @objc private func yq_tap_add_count() {
        
        if ((self.yq_creat_time + JY_Loading_HUD_Manager.yq_shared.yq_timeout) < JY_Date_Tool.yq_get_current_timeInterval()) {
            yq_tap_count = yq_tap_count + 1
        }
        
        if yq_tap_count >= 5 {
            JY_Loading_HUD_Manager.yq_shared.yq_hidden_all_HUD()
        }
    }
    
}

public extension JY_Loading_HUD {
    /**
     显示loadingView
     toView: 显示在哪个控件控件中, 如果不传 就显示在主窗口上
     taskName: 任务名, 如果loading正在显示状态, 又调用一次相同任务名,则不会添加
     */
    @objc class func yq_show_loading(taskName: String) {
        //        class func yq_show_loading(toView view: UIView, taskName: String) {
        
        //        let showView = view == nil ? UIWindow.yq_first_window() : view!
        guard let showView = UIWindow.yq_first_window() else {
            return
        }
        
        
        DispatchQueue.main.async {
            let loadingHUD = JY_Loading_HUD()
            loadingHUD.yq_task_Name = taskName
            loadingHUD.yq_creat_time = JY_Date_Tool.yq_get_current_timeInterval()
            
            JY_Loading_HUD_Manager.yq_shared.yq_add_loading_HUD((showView: showView, LoadingHUD: loadingHUD))
        }
    }
    
    class func yq_hidden_loading(taskName: String) {
        
        DispatchQueue.main.async {
            JY_Loading_HUD_Manager.yq_shared.yq_hidden_loading_HUD(taskName: taskName)
        }
    }
}
