//
//  JY_Enum_Config.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import UIKit

extension JY_Sex: CaseIterable { }
enum JY_Sex {
    typealias RawValue = (Int, String)
    
    case unknown
    case male
    case female
    
    var rawValue: RawValue {
        switch self {
        case .unknown:
            return (-1, "未知")
        case .male:
            return (1, "男")
        case .female:
            return (0, "女")
        }
        
    }
    
    init?(intValue: Int) {
        for feedbackType in JY_Sex.allCases {
            if feedbackType.rawValue.0 == intValue {
                self = feedbackType
                return
            }
        }
        return nil
    }
}
