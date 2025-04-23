//
//  JY_Enum_BaseController_Status.swift
//  JY_ToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

public enum JY_Enum_BaseController_Status: Int {
    //  默认状态下 显示contentView
    case yq_default = -99
    
    case yq_loading = -98
    
    //  显示已经加载过数据
    case yq_data_loaded = -97
    
    case yq_show_status = 1
}
