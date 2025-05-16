//
//  JY_Version_Manager.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import UIKit

class JY_Version_Manager {
    
    static let yq_shared: JY_Version_Manager = JY_Version_Manager()
    
    private(set) lazy var yq_update: JY_Version_Update = JY_Version_Update()
    
    private init() {}
    
    deinit { }
    
}

extension JY_Version_Manager {
    static func yq_current_version() -> String {
        return UIApplication.yq_appVersion()
    }
}
