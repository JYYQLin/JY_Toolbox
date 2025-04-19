//
//  JY_Controller_Manager.swift
//  JYYQTools
//
//  Created by JYYQLin on 2025/1/17.
//

import UIKit

public let yq_controller_manager = JY_Controller_Manager.yq_shared

public class JY_Controller_Manager {
    
    static let yq_shared: JY_Controller_Manager = JY_Controller_Manager()

    private(set) lazy var yq_is_initialize: Bool = false
    
    private lazy var yq_log: String = ""
    
    private lazy var yq_is_debug: Bool = false
    
    private init() {}
    
    open func yq_initialize_manager() {
        if yq_is_initialize == true {
            return
        }
        
        yq_is_initialize = true
    }
    
    open func yq_add_log(controllerName: String, status: String) {
        let time = yq_dateFormat()
        
        let log = "time: " + time + " | " + "controllerName: " + controllerName + " | "  + "status: " + status + "\n"
        
        yq_log = yq_log + log
        
        if yq_is_debug == true {
            print(log)
        }
    }

    open func yq_set_log(log: String) {
        yq_log = log
    }

    open func yq_set(isDebug: Bool) {
        yq_is_debug = isDebug
    }
}

extension JY_Controller_Manager {
    private func yq_dateFormat() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
