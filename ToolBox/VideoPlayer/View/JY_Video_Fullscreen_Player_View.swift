//
//  JY_Video_Fullscreen_Player_View.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//
#if !os(macOS)
import UIKit

public class JY_Video_Fullscreen_Player_View: UIView {

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if let animation = layer.animation(forKey: "bounds.size") {
            CATransaction.begin()
            CATransaction.setAnimationDuration(animation.duration)
            CATransaction.setAnimationTimingFunction(animation.timingFunction)
            layer.sublayers?.forEach({ $0.frame = bounds })
            CATransaction.commit()
        } else {
            layer.sublayers?.forEach({ $0.frame = bounds })
        }
    }

}
#endif
