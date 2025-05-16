//
//  JY_Enum_Config + Video_Player.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/27.
//

import UIKit

enum JY_Action_Type {
    /** 本地 */
    case local
    /** 远程 */
    case remote
}

enum JY_Video_Speed: Float {
    case slow_7_5 = 0.75
    case normal = 1.0
    case fast_1_25 = 1.25
    case fast_1_5 = 1.5
    case fast_2_0 = 2
}
