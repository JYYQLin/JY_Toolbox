//
//  JY_Extension_UIDevice.swift
//  JYYQToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

//  MARK: UIDevice - 扩展
extension UIDevice {
    public static func yq_current_device_type() -> JY_Device_Type {
        
        var deviceType: JY_Device_Type? = nil
        
        let modelName = UIDevice.yq_modelName()
        
        for type in UIDevice.yq_supported_device_list() {
            //  先通过型号判断
            if type.modelName.contains(modelName) == true {
                deviceType = type
                break
            }
            
            //  如果型号判断不到， 就工具长宽判断一下
            else {
                
                let screenWidth = UIScreen.main.bounds.width > UIScreen.main.bounds.height ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
                let screenHeight = UIScreen.main.bounds.width <= UIScreen.main.bounds.height ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
                
                let screenScale = UIScreen.main.scale
                let screenNativeScale = UIScreen.main.nativeScale
                
                if type.width == screenWidth && type.height == screenHeight && (type.screenScale == screenScale || screenNativeScale == type.screenScale) {
                    deviceType = type
                }
                
            }
        }
        
        if deviceType != nil {
            return deviceType!
        }else{
            //  如果不识别机型， 防止死循环，因为设计稿用的是iPhone 11所以就用11作为默认
            return (width: 414, height: 896, statusHeight_V: 48, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 2.0, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 11", modelName: ["iPhone12,1"], isPad: false)
        }
        
    }
    
    public static func yq_modelName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
}

extension UIDevice {
    /** 支持设备列表 */
    static func yq_supported_device_list() -> [JY_Device_Type] {
        return  [
            //  非全面屏
            /**  4寸非全面屏屏幕设备 */
            (width: 320, height: 568, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 49, tabBarHeight_H: 32, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPhone SE 1st", modelName: ["iPhone8,4"], isPad: false),
            (width: 320, height: 568, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 49, tabBarHeight_H: 32, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPod Touch 7th", modelName: ["iPod9,1"], isPad: false),
            
            /**  4.7寸非全面屏屏幕设备 */
            (width: 375, height: 667, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 49, tabBarHeight_H: 32, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPhone 6s", modelName: ["iPhone8,1"], isPad: false),
            (width: 375, height: 667, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 49, tabBarHeight_H: 32, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPhone 7", modelName: ["iPhone9,1", "iPhone9,3"], isPad: false),
            (width: 375, height: 667, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 49, tabBarHeight_H: 32, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPhone 8", modelName: ["iPhone10,1", "iPhone10,4"], isPad: false),
            (width: 375, height: 667, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 49, tabBarHeight_H: 32, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPhone SE 2nd (2020)", modelName: ["iPhone12,8"], isPad: false),
            (width: 375, height: 667, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 49, tabBarHeight_H: 32, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPhone SE 3rd (2022)", modelName: ["iPhone14,6"], isPad: false),
            
            /**  5.5寸非全面屏屏幕设备 */
            (width: 414, height: 736, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 49, tabBarHeight_H: 49, screenScale: 3, isFullScreen: false, isDynamicIsland: false, deviceName: "iPhone 6s Plus", modelName: ["iPhone8,2"], isPad: false),
            (width: 414, height: 736, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 49, tabBarHeight_H: 49, screenScale: 3, isFullScreen: false, isDynamicIsland: false, deviceName: "iPhone 7 Plus", modelName: ["iPhone9,2", "iPhone9,4"], isPad: false),
            (width: 414, height: 736, statusHeight_V: 20, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 49, tabBarHeight_H: 49, screenScale: 3, isFullScreen: false, isDynamicIsland: false, deviceName: "iPhone 8 Plus", modelName: ["iPhone10,2", "iPhone10,5"], isPad: false),
            
            
            //  全面屏
            /**  5.42寸全面屏设备 */
            (width: 375, height: 812, statusHeight_V: 50, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 12 mini", modelName: ["iPhone13,1"], isPad: false),
            (width: 375, height: 812, statusHeight_V: 50, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 13 mini", modelName: ["iPhone14,4"], isPad: false),
            
            /**  5.85寸全面屏设备 */
            (width: 375, height: 812, statusHeight_V: 44, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone XS", modelName: ["iPhone11,2"], isPad: false),
            (width: 375, height: 812, statusHeight_V: 44, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone X", modelName: ["iPhone10,3", "iPhone10,6"], isPad: false),
            (width: 375, height: 812, statusHeight_V: 44, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 11 Pro", modelName: ["iPhone12,3"], isPad: false),
            
            /**  6.06寸全面屏设备 - LCD */
            (width: 414, height: 896, statusHeight_V: 48, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone XR", modelName: ["iPhone11,8"], isPad: false),
            (width: 414, height: 896, statusHeight_V: 48, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 11", modelName: ["iPhone12,1"], isPad: false),
            
            /**  6.06寸全面屏设备 - OLED */
            (width: 390, height: 844, statusHeight_V: 47, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 12", modelName: ["iPhone13,2"], isPad: false),
            (width: 390, height: 844, statusHeight_V: 47, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 12 Pro", modelName: ["iPhone13,3"], isPad: false),
            (width: 390, height: 844, statusHeight_V: 47, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 13", modelName: ["iPhone14,5"], isPad: false),
            (width: 390, height: 844, statusHeight_V: 47, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 13 Pro", modelName: ["iPhone14,2"], isPad: false),
            (width: 390, height: 844, statusHeight_V: 47, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 14", modelName: ["iPhone14,7"], isPad: false),
            
            
            
            /**  6.46寸全面屏设备 */
            (width: 414, height: 896, statusHeight_V: 44, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone XS Max", modelName: ["iPhone11,6", "iPhone11,4"], isPad: false),
            (width: 414, height: 896, statusHeight_V: 44, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 11 Pro Max", modelName: ["iPhone12,5"], isPad: false),
            
            
            /**  6.68寸全面屏设备 */
            (width: 428, height: 926, statusHeight_V: 47, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 12 Pro Max", modelName: ["iPhone13,4"], isPad: false),
            (width: 428, height: 926, statusHeight_V: 47, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 13 Pro Max", modelName: ["iPhone14,3"], isPad: false),
            (width: 428, height: 926, statusHeight_V: 47, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: false, deviceName: "iPhone 14 Plus", modelName: ["iPhone14,8"], isPad: false),
            
            //  灵动岛设备
            /**  6.12寸全面屏设备 - 灵动岛设备 */
            (width: 393, height: 852, statusHeight_V: 53.6666666, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 15", modelName: ["iPhone15,4"], isPad: false),
            (width: 393, height: 852, statusHeight_V: 53.6666666, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 14 Pro", modelName: ["iPhone15,2"], isPad: false),
            (width: 393, height: 852, statusHeight_V: 53.6666666, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 15 Pro", modelName: ["iPhone16,1"], isPad: false),
            (width: 393, height: 852, statusHeight_V: 53.6666666, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 32, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 16", modelName: ["iPhone17,1"], isPad: false),
            
            
            /**  .69寸全面屏设备 - 灵动岛设备 */
            (width: 430, height: 932, statusHeight_V: 53.6666666, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 14 Pro Max", modelName: ["iPhone15,3"], isPad: false),
            (width: 430, height: 932, statusHeight_V: 53.6666666, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 15 Plus", modelName: ["iPhone15,5"], isPad: false),
            (width: 430, height: 932, statusHeight_V: 53.6666666, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 15 Pro Max", modelName: ["iPhone16,2"], isPad: false),
            (width: 430, height: 932, statusHeight_V: 53.6666666, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 16 Plus", modelName: ["iPhone17,2"], isPad: false),

            /**  iPhone16 Pro系列 - 灵动岛设备 */
            (width: 402, height: 874, statusHeight_V: 56.3333333, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 53, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 16 Pro", modelName: ["iPhone17,3"], isPad: false),
            (width: 440, height: 956, statusHeight_V: 56.3333333, navigationBarHeight_V: 44, statusHeight_H: 0, navigationBarHeight_H: 44, tabBarHeight_V: 83, tabBarHeight_H: 70, screenScale: 3, isFullScreen: true, isDynamicIsland: true, deviceName: "iPhone 16 Pro Max", modelName: ["iPhone17,4"], isPad: false),
            
            
            
            //  平板设备
            /**  非全面屏平板 */
            (width: 768, height: 1024, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad 5th", modelName: ["iPad6,11", "iPad6,12"], isPad: true),
            (width: 768, height: 1024, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad 6th", modelName: ["iPad7,5", "iPad7,6"], isPad: true),
            (width: 810, height: 1080, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad 7th", modelName: ["iPad7,11", "iPad7,12"], isPad: true),
            (width: 810, height: 1080, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad 8th", modelName: ["iPad11,6", "iPad11,7"], isPad: true),
            (width: 810, height: 1080, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad 9th", modelName: ["iPad12,1", "iPad12,2"], isPad: true),
            (width: 768, height: 1024, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad Air 2", modelName: ["iPad5,3", "iPad5,4"], isPad: true),
            (width: 834, height: 1112, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad Air 3", modelName: ["iPad11,3", "iPad11,4"], isPad: true),
            (width: 768, height: 1024, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad Mini 4", modelName: ["iPad5,1", "iPad5,2"], isPad: true),
            (width: 768, height: 1024, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad Mini 5", modelName: ["iPad11,1", "iPad11,2"], isPad: true),
            (width: 768, height: 1024, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad Pro (9.7-inch) 1st", modelName: ["iPad6,3", "iPad6,4"], isPad: true),
            (width: 834, height: 1112, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad Pro (10.5-inch)", modelName: ["iPad7,3", "iPad7,4"], isPad: true),
            (width: 1024, height: 1366, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad Pro (12.9-inch) 1st", modelName: ["iPad6,7", "iPad6,8"], isPad: true),
            (width: 1024, height: 1366, statusHeight_V: 20, navigationBarHeight_V: 50, statusHeight_H: 20, navigationBarHeight_H: 50, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: false, isDynamicIsland: false, deviceName: "iPad Pro (12.9-inch) 2nd", modelName: ["iPad7,1", "iPad7,2"], isPad: true),
            
            /**  全面屏平板 */
            (width: 744, height: 1133, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Mini 6", modelName: ["iPad14,1", "iPad14,2"], isPad: true),
            (width: 820, height: 1180, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad 10th", modelName: ["iPad13,18", "iPad13,19"], isPad: true),
            (width: 820, height: 1180, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Air 4", modelName: ["iPad13,1", "iPad13,2"], isPad: true),
            (width: 820, height: 1180, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Air 5", modelName: ["iPad13,16", "iPad13,17"], isPad: true),
            (width: 834, height: 1194, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (11.0-inch) 1st Gen", modelName: ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"], isPad: true),
            (width: 834, height: 1194, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (11.0-inch) 2nd Gen", modelName: ["iPad8,9", "iPad8,10"], isPad: true),
            (width: 834, height: 1194, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (11.0-inch) 3rd Gen", modelName: ["iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7"], isPad: true),
            (width: 834, height: 1194, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (11.0-inch) 4th Gen", modelName: ["iPad14,3", "iPad14,4"], isPad: true),
            (width: 1024, height: 1366, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (12.9-inch) 3rd", modelName: ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"], isPad: true),
            (width: 1024, height: 1366, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (12.9-inch) 4th", modelName: ["iPad8,11", "iPad8,12"], isPad: true),
            (width: 1024, height: 1366, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (12.9-inch) 5th", modelName: ["iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11"], isPad: true),
            (width: 1024, height: 1366, statusHeight_V: 24, navigationBarHeight_V: 50, statusHeight_H: 24, navigationBarHeight_H: 50, tabBarHeight_V: 65, tabBarHeight_H: 65, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (12.9-inch) 6th", modelName: ["iPad14,5", "iPad14,6"], isPad: true),

            (width: 820, height: 1180, statusHeight_V: 24, navigationBarHeight_V: 64, statusHeight_H: 24, navigationBarHeight_H: 64, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Air (11.0-inch) 6th", modelName: ["iPad14,8", "iPad14,9"], isPad: true),
            (width: 1024, height: 1366, statusHeight_V: 24, navigationBarHeight_V: 64, statusHeight_H: 24, navigationBarHeight_H: 64, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Air (13.0-inch) 6th", modelName: ["iPad14,10", "iPad14,11"], isPad: true),
            (width: 834, height: 1210, statusHeight_V: 24, navigationBarHeight_V: 64, statusHeight_H: 24, navigationBarHeight_H: 64, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (11.0-inch) 7th", modelName: ["iPad16,3", "iPad16,4"], isPad: true),
            (width: 1032, height: 1376, statusHeight_V: 24, navigationBarHeight_V: 64, statusHeight_H: 24, navigationBarHeight_H: 64, tabBarHeight_V: 50, tabBarHeight_H: 50, screenScale: 2, isFullScreen: true, isDynamicIsland: false, deviceName: "iPad Pro (13.0-inch) 7th", modelName: ["iPad16,5", "iPad16,6"], isPad: true),
            
//            (width: 0, height: 0, statusHeight_V: 0, navigationBarHeight_V: 0, statusHeight_H: 0, navigationBarHeight_H: 0, tabBarHeight_V: 0, tabBarHeight_H: 0, screenScale: 0, isFullScreen: false, isDynamicIsland: false, deviceName: "Apple TV", modelName: ["AppleTV5,3"]),
//            (width: 0, height: 0, statusHeight_V: 0, navigationBarHeight_V: 0, statusHeight_H: 0, navigationBarHeight_H: 0, tabBarHeight_V: 0, tabBarHeight_H: 0, screenScale: 0, isFullScreen: false, isDynamicIsland: false, deviceName: "Simulator", modelName: ["i386", "x86_64"]),
        ]
    }
}
