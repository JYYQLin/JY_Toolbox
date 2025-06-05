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
        // 数值小于 1000，直接返回原始值
        guard self >= 1000 else {
            return "\(self)"
        }
        
        // 定义单位和除数
        let units = ["K", "M"]
        let divisors = [1_000, 1_000_000]
        
        // 遍历单位，找到合适的除数
        for i in 0..<units.count {
            let divisor = divisors[i]
            if self >= divisor {
                // 计算数值并保留两位小数
                let value = Double(self) / Double(divisor)
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.minimumFractionDigits = 2 // 最少两位小数
                formatter.maximumFractionDigits = 2 // 最多两位小数
                
                // 拼接结果（如："1.23K"）
                if let formattedValue = formatter.string(from: NSNumber(value: value)) {
                    return "\(formattedValue)\(units[i])"
                }
            }
        }
        
        // 默认返回原始值（理论上不会执行到这里）
        return "\(self)"
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
