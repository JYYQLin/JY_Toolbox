//
//  JY_Extension_UIApplication.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit
import Photos

extension UIApplication {
    /// 获取当前BundleID
    public static func yq_bundle_identifier() -> String {
        guard let bundleIdentifier = Bundle.main.infoDictionary!["CFBundleIdentifier"] as? String else {return "命名空间错误"}
        return bundleIdentifier
    }
    
    /// 获取当前版本号
    public static func yq_appVersion() -> String {
        guard let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else{return "版本号错误"}
        return currentVersion
    }
}

extension UIApplication {
    /** 跳转应用设置 */
    public static func yq_push_application_setting(completionHandler: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(url) == true {
                UIApplication.shared.open(url, options: [:], completionHandler: completionHandler)
            }
        }
    }
}

extension UIApplication {

    /** 检测相册授权情况 */
    public static func yq_request_photo_authorization(_ handler: @escaping (_ isAuthorized: Bool, _ status: PHAuthorizationStatus) -> Void) {
        
        PHPhotoLibrary.requestAuthorization { status in
            if status == .notDetermined || status == .restricted || status == .denied{
                //  用户尚未作出关于这个应用的选择
                
                //  该应用程序未被授权访问照片库，用户也无法授予这样的权限。
                    // 比如家长控制。
                
                // 用户已明确拒绝此应用程序访问照片数据
                DispatchQueue.main.async {
                    handler(false, status)
                }
            }else if status == .authorized {
                // 用户已授权此应用程序访问照片数据
                DispatchQueue.main.async {
                    handler(true, status)
                }
            }else {
                if #available(iOS 14, *) {
                    if status == .limited {
                        // 用户授权此应用程序进行有限的照片库访问
                        DispatchQueue.main.async {
                            handler(true, status)
                        }
                    }
                } else {
                    //  未知, 按照未授权处理
                    DispatchQueue.main.async {
                        handler(false, status)
                    }
                }
            }
        }
    }
}
