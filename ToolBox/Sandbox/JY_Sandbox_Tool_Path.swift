//
//  JY_Sandbox_Tool_Path.swift
//  JYYQToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

//  Documents文件夹
extension JY_Sandbox_Tool {
    /** 获取沙盒Documents文件夹路径 */
    public static func yq_documents_path() -> String? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths.first
        return documentsDirectory?.path
    }
    
    /** 根据传入文件名，拼接Documents文件夹全路径 */
    public static func yq_appendPath_with_documents(fileName : String) -> String? {
        
        guard let path = yq_documents_path() else {
            return nil
        }
        
        /// 如果fileName是一个完整的URL，我们只需要URL最后的文件名和沙盒路径拼接
        /// pathComponents方法, 会按照字符串的『/』来切割字符串, 如果给定的字符串中没有『/』那么就直接返回给定的字符串
        guard let temp = (fileName as NSString).pathComponents.last else {
            return nil
        }
        
        let filePath = (path as NSString).appendingPathComponent(temp)
        return filePath
    }
}

//  MARK: Library文件夹
extension JY_Sandbox_Tool {
    /** 获取沙盒Library文件夹路径 */
    public static func yq_library_path() -> String? {
        let paths = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
        let libraryDirectory = paths.first
        return libraryDirectory?.path
    }
    
    /** 根据传入文件名，拼接Library文件夹全路径 */
    public static func yq_appendPath_with_library(fileName : String) -> String? {
        
        guard let path = yq_library_path() else {
            return nil
        }
        
        guard let temp = (fileName as NSString).pathComponents.last else {
            return nil
        }
    
        let filePath = (path as NSString).appendingPathComponent(temp)
        return filePath
    }
}

//  MARK: Cache文件夹
extension JY_Sandbox_Tool {
    /** 获取沙盒Cache文件夹路径 */
    public static func yq_caches_path() -> String? {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let cachesDirectory = paths.first
        return cachesDirectory?.path
    }
    
    /** 根据传入文件名，拼接Caches文件夹全路径 */
    public static func yq_appendPath_with_caches(fileName : String) -> String? {
        
        guard let path = yq_caches_path() else {
            return nil
        }
        
        guard let temp = (fileName as NSString).pathComponents.last else {
            return nil
        }
    
        let filePath = (path as NSString).appendingPathComponent(temp)
        return filePath
    }
}

//  MARK: Temp文件夹
extension JY_Sandbox_Tool {
    /** 获取沙盒Temp文件夹路径 */
    public static func yq_temp_path() -> String {
        //  Temp文件夹直接通过调用NSTemporaryDirectory获取
        return NSTemporaryDirectory()
    }
}
