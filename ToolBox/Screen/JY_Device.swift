//
//  JY_Device.swift
//  JY_ToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

/// 设备的硬件信息
/// - deviceName: 设备名
/// - modelName: 设备型号
/// - width: 宽度
/// - height: 高度
/// - statusHeight_V: 竖屏 - 状态栏高度
/// - navigationBarHeight_V: 竖屏 - 导航栏高度
/// - statusHeight_H: 横屏 - 状态栏高度
/// - navigationBarHeight_H: 横屏 - 导航栏高度
/// - tabBarHeight_V: 竖屏 - TabBar高度
/// - tabBarHeight_H: 横屏 - TabBar高度
/// - screenScale: 分辨率比例
/// - isFullScreen: 是否全面屏
/// - isDynamicIsland: 是否灵动岛
/// - isPad: 是否是平板
public typealias JY_Device_Type = (width: CGFloat, height: CGFloat, statusHeight_V: CGFloat, navigationBarHeight_V: CGFloat, statusHeight_H: CGFloat, navigationBarHeight_H: CGFloat, tabBarHeight_V: CGFloat, tabBarHeight_H: CGFloat, screenScale: CGFloat, isFullScreen: Bool, isDynamicIsland: Bool, deviceName: String, modelName: [String], isPad: Bool)

public let yq_current_device = JY_Device.yq_shared

//  MARK: JY_Device
public class JY_Device: NSObject {
    
    //  单例
    static let yq_shared = JY_Device()
    
    private lazy var yq_type: JY_Device_Type? = nil
    
    public func yq_device_type() -> JY_Device_Type {
        return yq_type ?? UIDevice.yq_current_device_type()
    }
}

extension JY_Device {
    /** TabBar高度 */
    public func yq_tabBar_height() -> CGFloat {
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        let screenHeight = window?.bounds.height ?? 0
        let screenWidth = window?.bounds.width ?? 0
        
        if screenWidth > screenHeight { //   横屏
            return yq_device_type().tabBarHeight_H
        }else{
            return yq_device_type().tabBarHeight_V
        }
    }
    
    /**
     给全面屏小横条预留的安全区域
     15这个值是个人试验后觉得比较合适的值
     */
    public func yq_tabBar_safe_height() -> CGFloat {
        let deviceType = self.yq_device_type()
        
        if deviceType.isFullScreen == false {
            return 0
        }else{ //  新推出的产品多为全面屏, 所以全面屏是默认值
            return 15
        }
    }
}

extension JY_Device {
    /** navigationBar高度 */
    public func yq_navigationBar_height() -> CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        let screenHeight = window?.bounds.height ?? 0
        let screenWidth = window?.bounds.width ?? 0
        
        if screenWidth > screenHeight { //   横屏
            return yq_device_type().navigationBarHeight_H
        }else{
            return yq_device_type().navigationBarHeight_V
        }
    }
    
    
    /** 状态栏的高度 */
    public func yq_statusBar_height() -> CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        let screenHeight = window?.bounds.height ?? 0
        let screenWidth = window?.bounds.width ?? 0
        
        if screenWidth > screenHeight { //   横屏
            return yq_device_type().statusHeight_H
        }else{
            return yq_device_type().statusHeight_V
        }
    }
    
    /** 导航条默认高度 + 状态栏高度 */
    public func yq_navigationBar_maxY() -> CGFloat {
        return yq_navigationBar_height() + yq_statusBar_height()
    }
}
