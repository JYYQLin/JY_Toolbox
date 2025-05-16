//
//  AVAssetResourceLoadingRequest+Extensions.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import AVFoundation

extension AVAssetResourceLoadingRequest {
    
    var url: URL? {
        request.url?.deconstructed
    }
    
}
