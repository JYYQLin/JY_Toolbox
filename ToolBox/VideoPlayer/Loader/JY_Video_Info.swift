//
//  JY_Video_Info.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import Foundation

struct JY_Video_Info: Codable {
    
    var contentLength: Int
    var contentType: String
    var isByteRangeAccessSupported: Bool
    
    init(contentLength: Int, contentType: String, isByteRangeAccessSupported: Bool) {
        self.contentLength = contentLength
        self.contentType = contentType
        self.isByteRangeAccessSupported = isByteRangeAccessSupported
    }
    
}
