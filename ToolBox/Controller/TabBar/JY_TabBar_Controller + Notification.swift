//
//  JY_TabBar_Controller + Notification.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import UIKit

//  MARK: TabBar选中了Controller的通知
extension JY_TabBar_Controller {
    class func yq_tabBarController_didSelect_notification_name() -> String {
        let name =  "\(self)" + "\(#function)"
        return name.yq_md5()
    }
    
    class func yq_add_tabBarController_didSelect_notification(_ observer: Any, selector aSelector: Selector, object anObject: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: NSNotification.Name(JY_TabBar_Controller.yq_tabBarController_didSelect_notification_name()), object: anObject)
    }
    
    class func yq_remove_tabBarController_didSelect_notification(_ observer: Any, object anObject: Any? = nil) {
        
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(JY_TabBar_Controller.yq_tabBarController_didSelect_notification_name()), object: anObject)
    }
    
    class func yq_post_tabBarController_didSelect_notification(object anObject: Any? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(JY_TabBar_Controller.yq_tabBarController_didSelect_notification_name()), object: anObject)
    }
}
