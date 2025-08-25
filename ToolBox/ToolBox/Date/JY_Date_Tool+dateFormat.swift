//
//  JY_Date_Tool+dateFormat.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/14.
//

import UIKit

//  MARK: 格式化时间 - 将时间戳转为对应MMDD格式
extension JY_Date_Tool {
    /**
     格式化时间
     自动判断时间戳是秒级还是毫秒级，转为指定格式（默认MM-dd）
     
     - Parameters:
       - time: 时间戳（支持秒级或毫秒级）
       - dateFormat: 目标日期格式，默认"MM-dd"
     - Returns: 格式化后的日期字符串
     */
    public static func yq_dateFormat(time: TimeInterval, dateFormat: String = "MM-dd") -> String {
        // 处理可能的毫秒级时间戳（阈值：大于10^12认为是毫秒，可根据实际需求调整）
        let timestamp = time > 1_000_000_000_000 ? time / 1000 : time
        
        // 创建时间格式化对象
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "en")
        fmt.dateFormat = dateFormat
        
        let date = Date(timeIntervalSince1970: timestamp)
        return fmt.string(from: date)
    }
}

extension Int {
    /**
     格式化时间
        将时间戳转为对应MMDD格式
     */
    public func yq_dateFormat(dateFormat: String = "MM-dd") -> String {
     
        return JY_Date_Tool.yq_dateFormat(time: TimeInterval(self), dateFormat: dateFormat)
    }
}

extension TimeInterval {
    /**
     距离当前时间
            传入未来的时间戳
            返回跟现在时间比, 还有多少天/时/分/秒
     */
    public func yq_dateFormat(dateFormat: String = "MM-dd") -> String {
     
        return JY_Date_Tool.yq_dateFormat(time: self, dateFormat: dateFormat)
    }
}



//  MARK: 格式化时间 - 特别处理成刚刚/几分钟前这类格式
extension JY_Date_Tool {
    /**
     格式化时间
        特别处理成刚刚 / 几分钟前这类格式
     */
    public static func yq_dateFormat_special_handling(time timestamp: TimeInterval) -> String {
        let currentDate = Date()
        let targetDate = Date(timeIntervalSince1970: timestamp)
        let timeDifference = currentDate.timeIntervalSince(targetDate)
        let calendar = Calendar.current

        if timeDifference < 60 {
            return "刚刚"
        } else if timeDifference < 3600 {
            let minutes = Int(timeDifference / 60)
            return "\(minutes)分钟前"
        } else if timeDifference < 86400 {
            let hours = Int(timeDifference / 3600)
            return "\(hours)小时前"
        }

        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentWeek = calendar.component(.weekOfYear, from: currentDate)

        let targetYear = calendar.component(.year, from: targetDate)
        let targetMonth = calendar.component(.month, from: targetDate)
        let targetWeek = calendar.component(.weekOfYear, from: targetDate)

        if currentYear == targetYear {
            if currentMonth == targetMonth {
                if currentWeek == targetWeek {
                    let days = Int(timeDifference / 86400)
                    return "\(days)天前"
                } else if currentWeek - targetWeek == 1 {
                    return "上周"
                } else if timeDifference < 2592000 { // 30 天
                    let weeks = Int(timeDifference / 604800)
                    return "\(weeks)周前"
                }
            } else if currentMonth - targetMonth == 1 {
                return "上个月"
            } else if timeDifference < 7776000 { // 3 个月
                return "一个月前"
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd"
                return dateFormatter.string(from: targetDate)
            }
        } else if currentYear - targetYear == 1 {
            return "去年"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            return dateFormatter.string(from: targetDate)
        }
        return ""
    }
}

extension Int {
    /**
     格式化时间
        特别处理成刚刚 / 几分钟前这类格式
     */
    public func yq_dateFormat_special_handling() -> String {
     
        return JY_Date_Tool.yq_dateFormat_special_handling(time: TimeInterval(self))
    }
}

extension TimeInterval {
    /**
     格式化时间
        特别处理成刚刚 / 几分钟前这类格式
     */
    public func yq_dateFormat_special_handling(dateFormat: String = "MM-dd") -> String {
     
        return JY_Date_Tool.yq_dateFormat_special_handling(time: self)
    }
}
