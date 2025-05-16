//
//  JY_Json_Tool.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/14.
//

import UIKit

open class JY_Json_Tool {
    
}

//  MARK: 将[String: Any]转成对应的Json字符串
public extension JY_Json_Tool {
    /**
     将[String: Any]转成对应的Json字符串
     */
    static func yq_dictionary_to_JSONString(_ dictionary: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting dictionary to JSON: \(error)")
        }
        return nil
    }
}

//  MARK: 将[Any]转成对应的Json字符串
public extension JY_Json_Tool {
    /**
     将[Any]转成对应的Json字符串
     */
    static func yq_array_to_JSONString(_ array: [[Any]]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("将数组转为 JSON 时出错: \(error)")
        }
        return nil
    }
}

public extension JY_Json_Tool {
    /// json字符串转字典
    /// - Parameter jsonStirng: json字符串
    /// - Returns: 字典(类型[String : Any])
    static func yq_JSONString_to_dictionary(from jsonStirng: String) -> [String : Any]? {
        guard let data = yq_JSONString_to_Objc(from: jsonStirng) else {
            return nil
        }
        return data as? [String : Any]
    }
}

//  MARK: json字符串转对象
public extension JY_Json_Tool {
    /// json字符串转对象
    /// - Parameter jsonStirng: json字符串
    /// - Returns: 对象(类型Any)
    static func yq_JSONString_to_Objc(from jsonStirng: String) -> Any? {
        guard let data = jsonStirng.data(using: .utf8) else {
            return nil
        }
        
        let obj = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        return obj
    }
}
