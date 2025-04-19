//
//  JY_Date_Tool+Distance_Now.swift
//  JYYQToolBox
//
//  Created by JYYQToolBox on 2025/4/14.
//

import UIKit

extension JY_Date_Tool {
    /**
     距离当前时间
            传入未来的时间戳
            返回跟现在时间比, 还有多少天/时/分/秒
     */
    public static func yq_distance_from_now(to futureTimestamp: TimeInterval) -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let currentDate = Date()
        let futureDate = Date(timeIntervalSince1970: futureTimestamp)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: futureDate)
        
        guard let days = components.day, let hours = components.hour, let minutes = components.minute, let seconds = components.second else {
            return (0, 0, 0, 0)
        }
        
        return (days <= 0 ? 0 : days, hours <= 0 ? 0 : hours, minutes <= 0 ? 0 : minutes, seconds <= 0 ? 0 : seconds)
    }
}

extension Int {
    /**
     距离当前时间
            传入未来的时间戳
            返回跟现在时间比, 还有多少天/时/分/秒
     */
    public func yq_distance_from_now() -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
     
        return JY_Date_Tool.yq_distance_from_now(to: TimeInterval(self))
    }
}

extension TimeInterval {
    /**
     距离当前时间
            传入未来的时间戳
            返回跟现在时间比, 还有多少天/时/分/秒
     */
    public func yq_distance_from_now() -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
     
        return JY_Date_Tool.yq_distance_from_now(to: self)
    }
}
