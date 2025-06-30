//
//  JY_Extension_String.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/14.
//

import UIKit

extension String {
    public func yq_highLight(normalColor: UIColor, highlightColor: UIColor, highlightTexts: [String]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let fullRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.foregroundColor, value: normalColor, range: fullRange)
        
        for text in highlightTexts {
            let nsString = self as NSString
            var searchRange = NSRange(location: 0, length: nsString.length)
            
            // 修复：直接赋值并检查 location
            var range = nsString.range(of: text, options: [], range: searchRange)
            while range.location != NSNotFound {
                attributedString.addAttribute(.foregroundColor, value: highlightColor, range: range)
                
                searchRange.location = range.location + range.length
                searchRange.length = nsString.length - searchRange.location
                range = nsString.range(of: text, options: [], range: searchRange)
            }
        }
        
        return attributedString
    }
}



//  MARK: 富文本 - 特定文字高亮
extension String {

    /** 
     字符串设置特定文字高亮 - normalColor: 普通文字颜色, hightLightText: 需要高亮的问题, hightLightColor: 高亮文字颜色
     **/
    public func yq_highLight(normalColor: UIColor, hightLightText: String, hightLightColor: UIColor) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        
        attributedString.addAttribute(.foregroundColor, value: normalColor, range: NSRange(location: 0, length: self.count))
        
        let range = self.range(of: hightLightText)
        if range != nil {
            let nsRange = NSRange(range!, in: self)
            attributedString.addAttribute(.foregroundColor, value: hightLightColor, range: nsRange)
        }
        
        return attributedString
    }
    
    /**
     字符串设置行间距 - lineSpacing: 行间距大小
     */
    public func yq_lineSpacing(lineSpacing: CGFloat) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        // 设置行间距
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    /**
     字符串设置下划线
     */
    public func yq_underLineStyle() -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        
        // 设置行间距
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
}

//  MARK: 富文本
extension NSAttributedString {
     
    /** 富文本 - 修改字体**/
    public func yq_font(font: UIFont) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(attributedString: self)
                
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: self.length))
        
        return attributedString
    }
    
    
    /** 富文本 - 修改颜色 **/
    public func yq_add(textColor: UIColor) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        
        attributedString.addAttribute(.foregroundColor, value: textColor, range: NSRange(location: 0, length: self.length))
        
        return attributedString
    }
    
    /** 富文本 -  修改行间距 **/
    public func yq_lineSpacing(lineSpacing: CGFloat) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        // 设置行间距
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: self.length))
        
        return attributedString
    }
}

//  MARK: 截取字符串
extension String {
    /** 截取字符串 */
    public func yq_truncate_string(toLength length: Int) -> String {
        if length >= self.count {
            return self
        }
        let endIndex = self.index(self.startIndex, offsetBy: length)
        return String(self[..<endIndex])
    }
}

//  MARK: 将字符串转为*号
extension String {
    /** 将字符串转为*号
     start表示从哪个字符开始
     length表示长度
     */
    public func yq_mask_characters(start: Int, length: Int) -> String {
        if start < 0 || length < 0 || start >= self.count {
            return self
        }
        var result = Array(self)
        let endIndex = min(start + length, self.count)
        for i in start..<endIndex {
            result[i] = "*"
        }
        return String(result)
    }
    
    public func yq_isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Z|a-z]{2,}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

extension String {
    /// 提取URL中最后一个斜杠后的部分
    /// - Returns: 最后一个路径组件，如果没有斜杠则返回原始字符串
    func lastPathComponent() -> String {
        // 处理空字符串
        guard !isEmpty else { return "" }
        
        // 使用Foundation的URL类处理标准URL格式
        if let url = URL(string: self) {
            return url.lastPathComponent
        }
        
        // 手动处理非标准URL格式（例如缺少协议的路径）
        let components = split(separator: "/").map(String.init)
        return components.last ?? self
    }
    
    /// 提取URL中文件扩展名（如果有）
    /// - Returns: 文件扩展名（不带点），如果没有则返回空字符串
    func pathExtension() -> String {
        // 处理空字符串
        guard !isEmpty else { return "" }
        
        // 使用Foundation的URL类处理标准URL格式
        if let url = URL(string: self) {
            return url.pathExtension
        }
        
        // 手动处理非标准URL格式
        let lastComponent = lastPathComponent()
        let extComponents = lastComponent.split(separator: ".").map(String.init)
        return extComponents.count > 1 ? extComponents.last! : ""
    }
}
