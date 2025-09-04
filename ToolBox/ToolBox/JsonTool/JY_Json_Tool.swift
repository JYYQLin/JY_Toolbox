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
    
    static func yq_dicArray_to_JSONString(array: [[String: Any]]) -> String? {
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
    
    /// 将 **[String] 字符串数组** 转换为 JSON 格式字符串（JSON 数组形式：["str1","str2",...]）
    /// - Parameter stringArray: 待转换的字符串数组（元素为 String，支持包含中文、特殊字符，JSON 会自动转义）
    /// - Returns: 格式化后的 JSON 字符串（带缩进，易读），转换失败返回 nil
    static func yq_stringArray_to_JSONString(_ stringArray: [String]) -> String? {
        do {
            // 1. 将 [String] 序列化为 JSON 数据
            // 注意：[String] 是 JSON 支持的类型（JSON 数组元素允许为字符串），无需额外处理
            let jsonData = try JSONSerialization.data(
                withJSONObject: stringArray,
                options: .prettyPrinted // 保留缩进，生成易读的 JSON 格式
            )
            
            // 2. 将 JSON 数据转为 UTF-8 编码的字符串
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            } else {
                print("JSON 数据转字符串失败：UTF-8 编码不支持")
                return nil
            }
        } catch {
            // 3. 捕获序列化异常（如数组包含 JSON 不支持的特殊格式，但 [String] 理论上不会触发）
            print("字符串数组转 JSON 失败：\(error.localizedDescription)")
            return nil
        }
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
