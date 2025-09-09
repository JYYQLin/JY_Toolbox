//
//  JY_Extension_Float.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/14.
//

import UIKit

extension String {
    /// 将以“分”为单位的纯数字字符串拆分为“元”和“分”
    /// - Returns: 元字符串和分字符串的元组 (yuan, fen)
    public func yq_split_yuan_fen() -> (yuan: String, fen: String) {
        // 确保字符串只包含非数字字符
        guard allSatisfy({ $0.isNumber }) else {
            return ("0", "00") // 非纯数字返回，返回默认值
        }
        
        let trimmed = self.trimmingCharacters(in: .whitespaces) // 去除空格
        guard !trimmed.isEmpty else {
            return ("0", "00") // 空字符串，返回默认值
        }
        
        // 处理长度不足2位的情况（如 "5" 表示 0元05分）
        if trimmed.count < 2 {
            let fen = String(repeating: "0", count: 2 - trimmed.count) + trimmed
            return ("0", fen)
        }
        
        // 正常情况：最后两位是分，前面是元
        let fenEndIndex = trimmed.index(trimmed.endIndex, offsetBy: -2)
        let yuanPart = String(trimmed[..<fenEndIndex])
        let fenPart = String(trimmed[fenEndIndex...])
        
        // 处理元部分为空的情况（如 "99" 表示 0元99分）
        let yuan = yuanPart.isEmpty ? "0" : yuanPart
        
        return (yuan, fenPart)
    }
}

extension Int {
    /**
     保留指定小数位数，并在小数部分全为0时自动移除小数点，同时添加千位分隔符
     
     - Parameter f: 要保留的小数位数
     - Returns: 格式化后的字符串
     */
    public func yq_fen_money_format(f: Int) -> String {
        let moneyText = "\(self)"
        
        var intText = ""
        var floatText = ""
        if self < 100 {
            return "0." + moneyText
        }
        else {
            let value = moneyText.yq_split_yuan_fen()
            intText = value.yuan
            floatText = value.fen
            
            return intText + "." + floatText
        }
    }
}

extension String {
    /**
     保留指定小数位数，并在小数部分全为0时自动移除小数点，同时添加千位分隔符
     
     - Parameter f: 要保留的小数位数
     - Returns: 格式化后的字符串
     */
    public func yq_money_format() -> String {
        
        // 检查是否包含小数点，分割整数和小数部分
        let components = self.components(separatedBy: ".")
        let integerPart = components[0]
        let fractionalPart = components.count > 1 ? components[1] : ""
        
        // 处理整数部分，添加千位分隔符
        let integerWithSeparator = addThousandSeparator(to: integerPart)
        
        // 处理小数部分，移除末尾的0
        let trimmedFractional = fractionalPart.replacingOccurrences(of: "0+$", with: "", options: .regularExpression)
        
        // 组合结果
        if trimmedFractional.isEmpty {
            return integerWithSeparator
        } else {
            return "\(integerWithSeparator).\(trimmedFractional)"
        }
    }
    
    /**
     为整数部分添加千位分隔符
     
     - Parameter numberString: 整数数字字符串
     - Returns: 添加分隔符后的字符串
     */
    private func addThousandSeparator(to numberString: String) -> String {
        // 处理负数情况
        let isNegative = numberString.hasPrefix("-")
        let absoluteString = isNegative ? String(numberString.dropFirst()) : numberString
        
        // 反转字符串以便从右向左每三位添加一个分隔符
        let reversed = String(absoluteString.reversed())
        var result = [String]()
        
        // 每三位一组拆分
        for i in 0..<reversed.count {
            if i > 0 && i % 3 == 0 {
                result.append(",")
            }
            result.append(String(reversed[reversed.index(reversed.startIndex, offsetBy: i)]))
        }
        
        // 反转回来并组合
        let separated = String(result.joined().reversed())
        
        // 如果是负数，添加负号
        return isNegative ? "-\(separated)" : separated
    }
}

extension Float {
    /**
     保留指定小数位数，并在小数部分全为0时自动移除小数点，同时添加千位分隔符
     
     - Parameter f: 要保留的小数位数
     - Returns: 格式化后的字符串
     */
    public func yq_money_format(f: Int) -> String {
        // 首先按照指定精度格式化数字
        let formatted = String(format: "%.\(f)f", self)
        
        // 检查是否包含小数点，分割整数和小数部分
        let components = formatted.components(separatedBy: ".")
        let integerPart = components[0]
        let fractionalPart = components.count > 1 ? components[1] : ""
        
        // 处理整数部分，添加千位分隔符
        let integerWithSeparator = addThousandSeparator(to: integerPart)
        
        // 处理小数部分，移除末尾的0
        let trimmedFractional = fractionalPart.replacingOccurrences(of: "0+$", with: "", options: .regularExpression)
        
        // 组合结果
        if trimmedFractional.isEmpty {
            return integerWithSeparator
        } else {
            return "\(integerWithSeparator).\(trimmedFractional)"
        }
    }
    
    /**
     为整数部分添加千位分隔符
     
     - Parameter numberString: 整数数字字符串
     - Returns: 添加分隔符后的字符串
     */
    private func addThousandSeparator(to numberString: String) -> String {
        // 处理负数情况
        let isNegative = numberString.hasPrefix("-")
        let absoluteString = isNegative ? String(numberString.dropFirst()) : numberString
        
        // 反转字符串以便从右向左每三位添加一个分隔符
        let reversed = String(absoluteString.reversed())
        var result = [String]()
        
        // 每三位一组拆分
        for i in 0..<reversed.count {
            if i > 0 && i % 3 == 0 {
                result.append(",")
            }
            result.append(String(reversed[reversed.index(reversed.startIndex, offsetBy: i)]))
        }
        
        // 反转回来并组合
        let separated = String(result.joined().reversed())
        
        // 如果是负数，添加负号
        return isNegative ? "-\(separated)" : separated
    }
}
    

extension Float {
   public func yq_calculate_daily_allowance() -> Float? {
        // 获取当前日期
        let today = Date()
        
        // 使用当前日历
        let calendar = Calendar.current
        
        // 获取当前月份的天数范围
        guard let range = calendar.range(of: .day, in: .month, for: today) else {
            return nil
        }
        let daysInMonth = range.count
        
        // 获取今天是当月的第几天
        let dayOfMonth = calendar.component(.day, from: today)
        
        // 计算当月剩余天数（包括今天）
        let remainingDays = daysInMonth - dayOfMonth + 1
        
        // 防止除以零的情况
        guard remainingDays > 0 else {
            return nil
        }
        
        // 计算每天可用金额
        let dailyAllowance = self / Float(remainingDays)
        
        return dailyAllowance
    }
}
