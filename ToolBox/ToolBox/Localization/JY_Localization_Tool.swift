//
//  JY_Localization_Tool.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

public let yq_localized_manager = JY_Localization_Tool.yq_shared

open class JY_Localization_Tool: NSObject {
    
    static let yq_shared = JY_Localization_Tool()
    
    open lazy var yq_current_language: JY_Enum_Language = .yq_chinese
    
    private override init() {
        super.init()
        
       let currentLanguageValue = UserDefaults.standard.string(forKey: "yq_current_language_rawValue") ?? "yq_current_language_rawValue"
        yq_current_language = JY_Enum_Language(rawValue: currentLanguageValue) ?? .yq_chinese
    }
}

extension JY_Localization_Tool {
    public func yq_set(currentLanguage: JY_Enum_Language) {
        yq_current_language = currentLanguage
        
        UserDefaults.standard.set(currentLanguage.rawValue, forKey: "yq_current_language_rawValue")
    }
}

extension JY_Localization_Tool {
    public static func yq_language_string(_ language: JY_Enum_Language) -> String {
        
        if language == .yq_english {
            return "English"
        }
        
        else if language == .yq_english_Australia {
            return "English（Australia）"
        }
        
        else if language == .yq_english_UK {
            return "English（UK）"
        }
        
        else if language == .yq_english_CA {
            return "English（CA）"
        }

        else if language == .yq_french {
            return "French"
        }
        
        else if language == .yq_chinese_traditional {
            return "繁體中文"
        }
        
        else if language == .yq_chinese {
            return "简体中文"
        }
        
        else if language == .yq_chinese_traditional_hk {
            return "繁體中文（香港）"
        }
        
        else if language == .yq_chinese_traditional_tw {
            return "繁體中文（台湾）"
        }
        
        else {
            return "未知"
        }
    }
}
