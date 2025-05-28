//
//  JY_Tip_HUD.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/27.
//

import UIKit

open class JY_Tip_HUD: JY_View {

    private(set) lazy var yq_title_label: JY_Label = JY_Label()
    private(set) lazy var yq_title_bgImageView: UIImageView = UIImageView()
    
    lazy var yq_task_Name: String = ""
    lazy var yq_creat_time: Int = 0

    private(set) lazy var yq_animation_duartion: Double = 2.25
}

extension JY_Tip_HUD {
    open override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_title_bgImageView)
        yq_title_bgImageView.addSubview(yq_title_label)
    }
    
    func yq_size(scale: CGFloat) -> CGSize {
        
        yq_set(scale: scale)
        
        yq_title_label_frame()
        
        return CGSize(width: yq_title_label.frame.width + 12 * scale * 2, height: yq_title_label.frame.height + 4 * scale * 2)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_title_bgImageView_frame()
        yq_title_label_frame()
    }
    
    private func yq_title_bgImageView_frame() {
        yq_title_bgImageView.frame.origin = {
            yq_title_bgImageView.frame.size = bounds.size
            yq_title_bgImageView.layer.cornerRadius = 12 * yq_scale
            yq_title_bgImageView.layer.masksToBounds = true
            return bounds.origin
        }()
    }
    
    private func yq_title_label_frame() {
        yq_title_label.frame.origin = {
            yq_title_label.text = yq_task_Name
            yq_title_label.font = UIFont.systemFont(ofSize: 13 * yq_scale)
            yq_title_label.textColor = UIColor.yq_color(colorString: "#FAFAFA")
            yq_title_label.numberOfLines = 0
            yq_title_label.textAlignment = .center
            yq_title_label.frame.size.width = 325 * yq_scale
            yq_title_label.sizeToFit()
            return CGPoint(x: (yq_title_bgImageView.frame.width - yq_title_label.frame.width) * 0.5, y: (yq_title_bgImageView.frame.height - yq_title_label.frame.height) * 0.5)
        }()
    }
    
}

extension JY_Tip_HUD {
    open class func yq_success_bgColor() -> UIColor {
        return UIColor(named: "greenTipHUDColor") ?? UIColor.yq_color(colorString: "#4DC56C")
    }
    
    open class func yq_danger_bgColor() -> UIColor {
        return UIColor(named: "redTipHUDColor") ?? UIColor.yq_color(colorString: "#FF4B3B")
    }
}

extension JY_Tip_HUD {
    
    @objc open class func yq_show_success(tip text: String) {
        
        if text.count <= 0 {
            return
        }
        
        guard UIWindow.yq_first_window() != nil else {
            return
        }
        
        DispatchQueue.main.async {
            let tipHUD = JY_Tip_HUD()
            tipHUD.yq_task_Name = text
            tipHUD.yq_creat_time = JY_Date_Tool.yq_get_current_timeInterval()
            tipHUD.yq_title_bgImageView.backgroundColor = JY_Tip_HUD.yq_success_bgColor()
            
            JY_Tip_HUD_Manager.yq_shared.yq_add_tip_HUD(tipHUD)
        }
    }
    
    @objc open class func yq_show_danger(tip text: String) {
        
        if text.count <= 0 {
            return
        }
        
        guard UIWindow.yq_first_window() != nil else {
            return
        }
        
        DispatchQueue.main.async {
            let tipHUD = JY_Tip_HUD()
            tipHUD.yq_task_Name = text
            tipHUD.yq_creat_time = JY_Date_Tool.yq_get_current_timeInterval()
            tipHUD.yq_title_bgImageView.backgroundColor = JY_Tip_HUD.yq_danger_bgColor()
            
            JY_Tip_HUD_Manager.yq_shared.yq_add_tip_HUD(tipHUD)
        }
    }
    
}

extension JY_Tip_HUD {
    func performCustomAnimation(completion: (() -> Void)? = nil) {
        // 起始状态
        self.alpha = 0.25

        // 第一个动画：移动到 y = 当前 y + 50 且透明度为 1
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.fromValue = yq_current_device.yq_statusBar_height()
        positionAnimation.toValue = yq_current_device.yq_navigationBar_maxY()
        positionAnimation.duration = CATransaction.animationDuration()

        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0.25
        alphaAnimation.toValue = 1
        alphaAnimation.duration = CATransaction.animationDuration()

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, alphaAnimation]
        groupAnimation.duration = CATransaction.animationDuration()
        groupAnimation.fillMode = .forwards
        groupAnimation.isRemovedOnCompletion = false

        self.layer.add(groupAnimation, forKey: "firstAnimation")

        // 保持状态 1.25 秒
        DispatchQueue.main.asyncAfter(deadline: .now() + yq_animation_duartion) {
            // 第二个动画：返回最初状态
            let returnPositionAnimation = CABasicAnimation(keyPath: "position.y")
            returnPositionAnimation.fromValue = yq_current_device.yq_navigationBar_maxY()
            returnPositionAnimation.toValue = yq_current_device.yq_statusBar_height()
            returnPositionAnimation.duration = CATransaction.animationDuration()

            let returnAlphaAnimation = CABasicAnimation(keyPath: "opacity")
            returnAlphaAnimation.fromValue = 1
            returnAlphaAnimation.toValue = 0.25
            returnAlphaAnimation.duration = CATransaction.animationDuration()

            let returnGroupAnimation = CAAnimationGroup()
            returnGroupAnimation.animations = [returnPositionAnimation, returnAlphaAnimation]
            returnGroupAnimation.duration = CATransaction.animationDuration()
            returnGroupAnimation.fillMode = .forwards
            returnGroupAnimation.isRemovedOnCompletion = false
            
            returnGroupAnimation.delegate = AnimationDelegate(completion: {
                completion?()
            })

            self.layer.add(returnGroupAnimation, forKey: "secondAnimation")
        }
    }
}

class AnimationDelegate: NSObject, CAAnimationDelegate {
    private let completion: () -> Void

    init(completion: @escaping () -> Void) {
        self.completion = completion
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            completion()
        }
    }
}
