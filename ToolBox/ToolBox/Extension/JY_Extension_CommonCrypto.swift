//
//  JY_Extension_CommonCrypto.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2024/10/13.
//

import CommonCrypto
import Foundation

//  MARK: 字符串加密
extension String {
    /** md5加密 */
    public func yq_md5() -> String {
        let str = cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate()
        return hash as String
    }
}

//  MARK: 字符串加密
extension String {
    /** yq_base64加密 */
    public func yq_base64() -> String? {
        guard let data = data(using: .utf8, allowLossyConversion: true) else {
            return nil
        }
        return data.base64EncodedString()
    }
}
