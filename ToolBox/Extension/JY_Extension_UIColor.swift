//
//  JY_Extension_UIColor.swift
//  JY_ToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

extension UIColor{
    public static func yq_color(red : CGFloat, green : CGFloat, blue : CGFloat, alpha: CGFloat = 1.00) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

extension UIColor {
    public static func yq_random() -> UIColor {
        let r = arc4random() % 255
        let g = arc4random() % 255
        let b = arc4random() % 255
        return UIColor.yq_color(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b))
    }
}

extension UIColor {
    public static func yq_color(colorString : String) -> UIColor {
        var colorString = colorString
        colorString = colorString.uppercased()
        //  删除字符串中的空格
        colorString = colorString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (colorString.count == 8 && colorString.hasPrefix("0X")) || (colorString.count == 7 && colorString.hasPrefix("#")) {
            
            var range = NSRange()
            range.length = 2
            range.location = colorString.count == 7 ? 1 : 2
            //  r
            let rString = (colorString as NSString).substring(with: range)
            
            //  g
            range.location = colorString.count == 7 ? 3 : 4
            let gString = (colorString as NSString).substring(with: range)
            
            //  b
            range.location = colorString.count == 7 ? 5 : 6
            let bString = (colorString as NSString).substring(with: range)
            
            // 进制转换
            let r = yq_color_string_to_float(rString)
            let g = yq_color_string_to_float(gString)
            let b = yq_color_string_to_float(bString)
            
            return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
        }
        
        else if (colorString.count == 6) {
            var range = NSRange()
            range.length = 2
            range.location = 0
            //  r
            let rString = (colorString as NSString).substring(with: range)
            
            //  g
            range.location = 2
            let gString = (colorString as NSString).substring(with: range)
            
            //  b
            range.location = 4
            let bString = (colorString as NSString).substring(with: range)
            
            // 进制转换
            let r = yq_color_string_to_float(rString)
            let g = yq_color_string_to_float(gString)
            let b = yq_color_string_to_float(bString)
            
            return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
        }
        
        else{
            return UIColor.clear
        }
    }
}

extension UIColor {
    /** 将颜色转成对应的数字, 比如传入FF转成256,  num长度只能是2个字符 */
    private static func yq_color_string_to_float(_ num: String) -> CGFloat {
        
        if num.count != 2 {
            return 0
        }
        
        let str = num.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return CGFloat(sum)
    }
}
