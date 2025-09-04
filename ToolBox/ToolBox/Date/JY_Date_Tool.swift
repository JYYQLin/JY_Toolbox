//
//  JY_Date_Tool.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/14.
//

import UIKit

public class JY_Date_Tool {

}

extension JY_Date_Tool {
    /** 获取当前时间戳 */
    public class func yq_get_current_timeInterval() -> Int {
        let timestampInSeconds = Date().timeIntervalSince1970
        return Int(timestampInSeconds)
    }
}

extension Int {
    public func yq_seconds_to_minutes_and_second() -> String {
        let hours = self / 3600
          let minutes = (self % 3600) / 60
          let remainingSeconds = self % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        }
        else{
            return String(format: "%02d:%02d", minutes, remainingSeconds)
        }
      }
}



extension JY_Date_Tool {
    public static func yq_get_currentMonth_firstAndLastDay() -> String {
        let calendar = Calendar.current
        let today = Date()
        
        // 获取当月第一天
        let firstDayComponents = calendar.dateComponents([.year, .month], from: today)
        guard let firstDay = calendar.date(from: firstDayComponents) else {
            return ""
        }
        
        // 计算当月最后一天：获取下个月第一天，再减去一天
        var nextMonthComponents = DateComponents()
        nextMonthComponents.month = 1
        guard let nextMonthFirstDay = calendar.date(byAdding: nextMonthComponents, to: firstDay) else {
            return ""
        }
        guard let lastDay = calendar.date(byAdding: .day, value: -1, to: nextMonthFirstDay) else {
            return ""
        }
        
        // 格式化日期为"X月X日"格式
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "M月d日"
        
        let firstDayString = dateFormatter.string(from: firstDay)
        let lastDayString = dateFormatter.string(from: lastDay)
        
        return "\(firstDayString)～\(lastDayString)"
    }
}

extension JY_Date_Tool {
    /// 从"YYYY"格式的字符串中提取年份和月份
    /// - Parameter dateString: 符合"YYYY"格式的日期字符串
    /// - Returns: 包含年份和月份的元组 (year: Int)?，如果解析失败则返回nil
    public static func yq_extract_year(from dateString: String) -> (Int)? {
        // 按"-"分割字符串
        let components = dateString.components(separatedBy: "-")
        
        // 提取年份和月份字符串
        let yearString = components[0]
        
        // 检查年份和月份的格式是否正确
        guard yearString.count == 4 else {
            print("日期格式错误：\(dateString)，年份应为4位，月份应为2位")
            return nil
        }
        
        // 转换为整数
        guard let year = Int(yearString) else {
            print("无法将\(dateString)转换为整数")
            return nil
        }
        
        return (year)
    }
    
    /// 从"YYYY-MM"格式的字符串中提取年份和月份
    /// - Parameter dateString: 符合"YYYY-MM"格式的日期字符串
    /// - Returns: 包含年份和月份的元组 (year: Int, month: Int)?，如果解析失败则返回nil
    public static func yq_extract_year_month(from dateString: String) -> (year: Int, month: Int)? {
        // 按"-"分割字符串
        let components = dateString.components(separatedBy: "-")
        
        // 检查分割后的结果是否符合预期（必须是两部分）
        guard components.count == 2 else {
            print("日期格式错误：\(dateString)，应为YYYY-MM格式")
            return nil
        }
        
        // 提取年份和月份字符串
        let yearString = components[0]
        let monthString = components[1]
        
        // 检查年份和月份的格式是否正确
        guard yearString.count == 4, monthString.count == 2 else {
            print("日期格式错误：\(dateString)，年份应为4位，月份应为2位")
            return nil
        }
        
        // 转换为整数
        guard let year = Int(yearString), let month = Int(monthString) else {
            print("无法将\(dateString)转换为整数")
            return nil
        }
        
        // 检查月份是否在有效范围内
        guard (1...12).contains(month) else {
            print("月份无效：\(month)，必须在1-12之间")
            return nil
        }
        
        return (year, month)
    }
    
    /// 从"YYYY-MM-dd"格式的字符串中提取年、月、日
    /// - Parameter dateString: 符合"YYYY-MM-dd"格式的日期字符串
    /// - Returns: 包含年、月、日的元组 (year: Int, month: Int, day: Int)?，如果解析失败则返回nil
    public static func yq_extract_year_month_day(from dateString: String) -> (year: Int, month: Int, day: Int)? {
        // 按"-"分割字符串
        let components = dateString.components(separatedBy: "-")
        
        // 检查分割后的结果是否符合预期（必须是三部分）
        guard components.count == 3 else {
            print("日期格式错误：\(dateString)，应为YYYY-MM-dd格式")
            return nil
        }
        
        // 提取年、月、日字符串
        let yearString = components[0]
        let monthString = components[1]
        let dayString = components[2]
        
        // 检查年、月、日的格式是否正确
        guard yearString.count == 4, monthString.count == 2, dayString.count == 2 else {
            print("日期格式错误：\(dateString)，年份应为4位，月份和日期应为2位")
            return nil
        }
        
        // 转换为整数
        guard let year = Int(yearString), let month = Int(monthString), let day = Int(dayString) else {
            print("无法将\(dateString)转换为整数")
            return nil
        }
        
        // 检查月份是否在有效范围内
        guard (1...12).contains(month) else {
            print("月份无效：\(month)，必须在1-12之间")
            return nil
        }
        
        // 检查日期是否在有效范围内（考虑不同月份的天数差异）
        let daysInMonth: Int
        switch month {
        case 2:
            // 判断闰年（能被4整除且不能被100整除，或能被400整除）
            daysInMonth = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) ? 29 : 28
        case 4, 6, 9, 11:
            daysInMonth = 30
        default:
            daysInMonth = 31
        }
        
        guard (1...daysInMonth).contains(day) else {
            print("日期无效：\(day)，在\(year)年\(month)月中有效日期为1-\(daysInMonth)")
            return nil
        }
        
        return (year, month, day)
    }
}

extension JY_Date_Tool {
    /** 对比B-A差几天 */
    public static func yq_days_between_dates(dateA: String, dateB: String) -> Int? {
        // 创建日期格式化器
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC") // 使用UTC避免时区问题
        
        // 将字符串转换为日期
        guard let aDate = dateFormatter.date(from: dateA),
              let bDate = dateFormatter.date(from: dateB) else {
            return nil // 如果日期格式不正确，返回nil
        }
        
        // 计算天数差
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: aDate, to: bDate)
        
        return components.day
    }
}

extension JY_Date_Tool {
    /// 获取当前时间的年、月、日
    /// - Returns: 包含年、月、日的元组 (year: Int, month: Int, day: Int)
    public static func yq_get_current_year_month_day() -> (year: Int, month: Int, day: Int) {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        
        return (year, month, day)
    }
    
    /// 获取当前时间**前一天**的年、月、日（自动处理跨月/跨年场景，如1月1日的前一天是去年12月31日）
    /// - Returns: 包含前一天年、月、日的元组 (year: Int, month: Int, day: Int)
    public static func yq_get_yesterday_year_month_day() -> (year: Int, month: Int, day: Int) {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // 1. 计算当前日期的前一天：给当前日期添加“-1天”的偏移
        // 注：Calendar的date(byAdding:)方法会自动处理跨月/跨年逻辑（如1月1日→12月31日）
        guard let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: currentDate) else {
            // 极端情况下（如系统时间异常）若计算失败，默认返回当前日期（避免崩溃）
            let fallback = yq_get_current_year_month_day()
            print("计算前一天日期失败，返回当前日期作为 fallback：\(fallback.year)-\(fallback.month)-\(fallback.day)")
            return fallback
        }
        
        // 2. 从“前一天日期”中提取年、月、日
        let year = calendar.component(.year, from: yesterdayDate)
        let month = calendar.component(.month, from: yesterdayDate)
        let day = calendar.component(.day, from: yesterdayDate)
        
        return (year, month, day)
    }
    
    /// 从指定时间戳获取对应的年、月、日
    /// - Parameter timestamp: 时间戳（秒）
    /// - Returns: 包含年、月、日的元组 (year: Int, month: Int, day: Int)
    public static func yq_get_year_month_day(from timestamp: TimeInterval) -> (year: Int, month: Int, day: Int) {
        let date = Date(timeIntervalSince1970: timestamp)
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return (year, month, day)
    }
}
