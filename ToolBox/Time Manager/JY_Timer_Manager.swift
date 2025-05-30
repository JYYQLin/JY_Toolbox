//
//  JY_Timer_Manager.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/24.
//

import UIKit

open class JY_Timer_Manager {
    // 定义单例实例
    public static let yq_shared = JY_Timer_Manager()
    // 私有化初始化方法，防止外部创建新的实例
    private init() {}
        
    private var yq_timer: Timer?
    
    /** 本次运行时间 */
    public lazy var yq_run_time: Int = 0
    
    private(set) lazy var yq_is_debug: Bool = false
    private lazy var yq_log_interval: Int = 1
    
    deinit {
        yq_stopTimer()
    }
}

public extension JY_Timer_Manager {
    func yq_set(isDebug: Bool) {
        yq_is_debug = isDebug
    }
    
    func yq_set(logInterval: Int) {
        yq_log_interval = logInterval
    }
}

public extension JY_Timer_Manager {
    /** 开始定时器 */
    func yq_start_timer() {
        if yq_check_timer_running() == true {
            return
        }
        yq_run_time = 0
        yq_set_up_timer()
    }
    
    private func yq_set_up_timer() {
        yq_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(yq_timer_fired), userInfo: nil, repeats: true)
        RunLoop.current.add(yq_timer!, forMode: .common)
    }
    
    /** 停止定时器 */
    func yq_stopTimer() {
        yq_timer?.invalidate()
        yq_timer = nil
    }
    
    /** 确认定时器是否启动 */
    func yq_check_timer_running() -> Bool {
        return yq_timer != nil && yq_timer!.isValid
    }
    
    /** 恢复定时器 */
    func yq_ensure_timer_running() {
        if !yq_check_timer_running() {
            yq_set_up_timer()
        }
    }
}

public extension JY_Timer_Manager {
    @objc private func yq_timer_fired() {
        
        yq_run_time = yq_run_time + 1
        
        JY_Timer_Manager.yq_post_timer_fired_change_notification()
        
        if yq_is_debug == true {
            
            if yq_run_time % yq_log_interval == 0 ||  yq_run_time <= 1 {
                print("运行了 \(yq_run_time) 秒")
            }
            
        }
    }
}


//  MARK: 定时器通知
public extension JY_Timer_Manager {
    
    class func yq_timer_fired_change_notification_name() -> String {
        let name = ("\(self)" + "_" + "\(#function)")
        
        return name.yq_md5()
    }
    
    class func yq_add_timer_fired_change_notification(_ observer: Any, selector aSelector: Selector, object anObject: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: NSNotification.Name(JY_Timer_Manager.yq_timer_fired_change_notification_name()), object: anObject)
    }
    
    class func yq_remove_timer_fired_change_notification(_ observer: Any, object anObject: Any? = nil) {
        
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(JY_Timer_Manager.yq_timer_fired_change_notification_name()), object: anObject)
    }
    
    class func yq_post_timer_fired_change_notification(object anObject: Any? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(JY_Timer_Manager.yq_timer_fired_change_notification_name()), object: anObject)
    }
}
