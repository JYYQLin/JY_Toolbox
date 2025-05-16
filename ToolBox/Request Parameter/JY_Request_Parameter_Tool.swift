//
//  JY_Request_Parameter_Tool.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import UIKit
//import KeychainAccess

class JY_Request_Parameter_Tool {
    
//    static func yq_UUID() -> String {
//        
//        let KEYCHAIN_SERVICE: String = UIApplication.yq_bundle_identifier()
//        let ISC_KEY: String = "IMEI"
//        
//        let keychain = Keychain(service: KEYCHAIN_SERVICE)
//        var uuid:String = ""
//        do {
//            uuid = try keychain.get(ISC_KEY) ?? ""
//        }
//        catch let error {
//            print(error)
//        }
//        
//        if uuid.isEmpty {
//            // 获取设备的唯一标识符, 卸载重装会变化
//            uuid = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
//            do {
//                try keychain.set(uuid, key: ISC_KEY)
//            }
//            catch let error {
//                print(error)
//                // iOS内核版本
//                uuid = ProcessInfo.processInfo.operatingSystemVersionString
//            }
//        }
//        return uuid.uppercased()
//    }
}
 
extension JY_Request_Parameter_Tool {
    static func yq_merge_parameters(parameters : [String : Any]? = nil) -> [String : Any] {
                
        var baseParameters: [String : Any] = [
            "channel": "ios",
            "language" : (JY_Request_Parameter_Tool.yq_language_Int_value()),
//            "unique_id": JY_Request_Parameter_Tool.yq_UUID(),
            "system_version": UIDevice.current.systemVersion,
            "phone_model": (yq_current_device.yq_device_type().deviceName.count > 0 ? yq_current_device.yq_device_type().deviceName : UIDevice.yq_modelName())
        ]
                
        if parameters != nil {
            return JY_Request_Parameter_Tool.yq_merge(a: parameters!, b: baseParameters)
        }else{
            return baseParameters
        }
    }
}

extension JY_Request_Parameter_Tool {
    /** 参数合并 */
    static func yq_merge(a:[String: Any], b:[String: Any]) -> [String: Any]{
        var na = a
        for e in b{
            //如果key不存在，直接增加。存在的话就会更改。
            na[e.key] = b[e.key]
        }
        return na
    }
}

extension JY_Request_Parameter_Tool {
   class func yq_language_Int_value() -> Int {
        
        if yq_localized_manager.yq_current_language == .yq_english || yq_localized_manager.yq_current_language == .yq_english_UK || yq_localized_manager.yq_current_language == .yq_english_Australia {
            return 1
        }
        
       else if yq_localized_manager.yq_current_language == .yq_chinese_traditional || yq_localized_manager.yq_current_language.rawValue.starts(with: "zh") {
            return 2
        }
         
        else{
            return 1
        }
    }
}
