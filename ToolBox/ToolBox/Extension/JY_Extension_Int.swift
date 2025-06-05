//
//  JY_Extension_Int.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

//  MARK: 计算次方
extension Int {
    /**
        计算次方 - 
     exponent: 几次方, 传入2就是平方, 传入3就是三次方, 6就是计算6次方
     */
    public func yq_power(_ exponent: Int) -> Int {
        var result = 1
        for _ in 0..<exponent {
            result *= self
        }
        return result
    }
}

extension Double {
    /**
        计算次方 -
     exponent: 几次方, 传入2就是平方, 传入3就是三次方, 6就是计算6次方
     */
    public func yq_power(_ exponent: Int) -> Double {
        var result = 1.0
        for _ in 0..<exponent {
            result *= self
        }
        return result
    }
}

// MARK: 数字单位化
extension Int {
    /**
          将1000以上的数字转为1.0k, 10000以上的数字转为1.0w的格式
     */
    public func yq_to_unitString_old() -> String {
        let numABS = abs(self)
        let sign = (self < 0) ? "-" : ""

        switch numABS {
        case 1_0000...:
            let formatted = Double(numABS) / 1_0000
            return "\(sign)\(formatted.yq_format(f: 2))w"
        case 1_000...:
            let formatted = Double(numABS) / 1_000
            return "\(sign)\(formatted.yq_format(f: 2))k"
        default:
            return "\(self)"
        }
    }
}

extension Int {
    /// 将数字转换为带有 K/M 后缀的缩写字符串（保留两位小数）
    public func yq_to_unitString() -> String {
        // 处理零或负数（直接返回原值）
        guard self != 0, self > 0 else {
            return "\(self)"
        }
        
        // 定义单位（基于 SI 单位制，10^3 进制）
        let units = ["K", "M", "G", "T", "P", "E"]
        let divisors: [Double] = [1e3, 1e6, 1e9, 1e12, 1e15, 1e18] // 对应 10^3, 10^6...
        
        // 找到合适的单位
        var value = Double(self)
        var unitIndex = -1
        
        for (i, divisor) in divisors.enumerated() {
            let tempValue = value / divisor
            if tempValue < 1000 { // 关键修改：当转换后的值小于1000时使用当前单位
                value = tempValue
                unitIndex = i
                break // 立即退出循环
            }
        }
        
        // 无单位时（数值 < 1000）
        guard unitIndex != -1 else {
            return "\(self)"
        }
        
        // 格式化数值（最多两位小数）
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0 // 最少 0 位小数（自动省略无效零）
        formatter.maximumFractionDigits = 2 // 最多 2 位小数
        
        if let formattedValue = formatter.string(from: NSNumber(value: value)) {
            return "\(formattedValue)\(units[unitIndex])"
        } else {
            return "\(self)" // 异常情况返回原值
        }
    }
}

extension Double {
    /**
            保留小数点 -
     f: 表示保留小数点几位
     */
    public func yq_format(f: Int) -> String {
         return String(format: "%.\(f)f", self)
     }
}


//extension Int {
//    public func yq_to_unitString() -> String {
//        if self > 1000 && self < 10000 {
//            return String(format: "%.1f", Double(self) / 1000.0) + "k"
//        }else if self > 10000 {
//            let count = Double(self) / 10000.0
//            return String(format: "%.1f", count) + "w"
//        }else{
//            return "\(self)"
//        }
//    }
//}
