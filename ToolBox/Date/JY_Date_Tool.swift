//
//  JY_Date_Tool.swift
//  JYYQToolBox
//
//  Created by JYYQToolBox on 2025/4/14.
//

import UIKit

public class JY_Date_Tool {

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
