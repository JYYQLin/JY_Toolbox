//
//  JY_Model.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import UIKit

class JY_Model {
    
    private(set) lazy var yq_dic: [String: Any] = [String: Any]()
}

extension JY_Model {
    @objc func yq_set(dic: [String: Any]) {
        
        yq_dic = dic
    }    
}

