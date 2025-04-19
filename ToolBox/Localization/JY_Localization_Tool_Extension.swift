//
//  JY_Localization_Tool_Extension.swift
//  JYYQToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

extension UIApplication {
    public static func yq_projectName() -> String {
        let bundle = Bundle.main
        let projectName = bundle.infoDictionary?["CFBundleName"] as? String ?? "Unknown Project Name"

        return projectName
    }
}

extension String {
    /**
     tableName: 本地化表名
     languageType: 预设的语言, 不传入则从yq_localized_manager去出当前设置的语言
     languageRawValue: 如果预设语言没包括所需要的语言, 这自己传入language表的真是名. 优先级大于languageType
     */
    public func yq_localized(tableName: String? = nil, languageType: JY_Enum_Language? = nil, languageRawValue: String? = nil) -> String {
        
        let systemLanguage = languageType == nil ? yq_localized_manager.yq_current_language : languageType
                
        if languageRawValue != nil {
            return NSLocalizedString(self, tableName: (tableName == nil ? UIApplication.yq_projectName() : tableName!), bundle:  Bundle(path: Bundle.main.path(forResource: languageRawValue!, ofType: "lproj") ?? "") ?? Bundle.main, value: "", comment: "")
        }
        else{
            return NSLocalizedString(self, tableName: (tableName == nil ? UIApplication.yq_projectName() : tableName!), bundle:  Bundle(path: Bundle.main.path(forResource: systemLanguage?.rawValue, ofType: "lproj") ?? "") ?? Bundle.main, value: "", comment: "")
        }
    }
}
