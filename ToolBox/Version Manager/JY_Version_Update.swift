//
//  JY_Version_Update.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import UIKit

enum JY_Version_Update_Type: Int {
    /** 0:不升级 */
    case do_not_upgrade = 0
    /** 1:提示更新 */
    case prompt_to_update = 1
    /** 2:强更 */
    case force_update = 2
}

class JY_Version_Update {
    
    lazy var yq_update_type: JY_Version_Update_Type = .do_not_upgrade
    lazy var yq_download_url: String = ""
    lazy var yq_remark: String = ""
    lazy var yq_version: String = ""
    lazy var yq_pass: Bool = false
}

extension JY_Version_Update {
    func yq_set(dic: [String: Any]) {
        
        let isPass = dic["is_audit"] as? Int
        if isPass != nil {
            yq_pass = isPass! == 0
        }
        
        let type = dic["type"] as? Int
        if type != nil {
            yq_update_type = JY_Version_Update_Type(rawValue: type!) ?? .do_not_upgrade
        }
        
        let url = dic["url"] as? String
        if url != nil {
            yq_download_url = url!
        }
        
        let remark = dic["remark"] as? String
        if remark != nil {
            yq_remark = remark!
        }
        
        let version = dic["name"] as? String
        if version != nil {
            yq_version = version!
        }
    }
}
