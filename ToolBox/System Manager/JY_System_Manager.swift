//
//  JY_System_Manager.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/15.
//

import UIKit

open class JY_System_Manager {
    
    public static let yq_shared: JY_System_Manager = JY_System_Manager()
    
     public lazy var yq_pay_debug: Bool = false
    
    private init() {}
    
    deinit { }
}

public extension JY_System_Manager {
    func yq_set(payDebug: Bool) {
        
        if payDebug != yq_pay_debug {
            yq_pay_debug = payDebug
        }
    }
}
