//
//  JY_Video_Speed_Set_Alert_View.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/27.
//

import UIKit

class JY_Video_Speed_Set_Alert_View: JY_View {
    
    private lazy var yq_currentSpeed: JY_Video_Speed = .normal
    
    private lazy var yq_bgImageView: UIImageView = UIImageView()
    
    private lazy var yq_cancel_button: UIButton = UIButton()
    private lazy var yq_normal_button: UIButton = UIButton()
    private lazy var yq_slow_7_5_button: UIButton = UIButton()
    private lazy var yq_fast_1_25_button: UIButton = UIButton()
    private lazy var yq_fast_1_5_button: UIButton = UIButton()
    private lazy var yq_fast_2_button: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(yq_bgImageView)
        
        addSubview(yq_cancel_button)
        addSubview(yq_normal_button)
        addSubview(yq_slow_7_5_button)
        addSubview(yq_fast_1_25_button)
        addSubview(yq_fast_1_5_button)
        addSubview(yq_fast_2_button)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension JY_Video_Speed_Set_Alert_View {
    
    func yq_set(currentSpeed: JY_Video_Speed) {
        yq_currentSpeed = currentSpeed
        layoutSubviews()
    }
}

extension JY_Video_Speed_Set_Alert_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_bgImageView.frame.origin = {
            yq_bgImageView.frame.size = bounds.size
            yq_bgImageView.image = UIImage.yq_generate_image(color: UIColor.yq_color(colorString: "#F8F8F8"), imageSize: yq_bgImageView.frame.size, cornerRadius: 10 * yq_scale, roundingCorners: [.topLeft, .topRight])
            return CGPoint(x: 0, y: 0)
        }()
        
        yq_cancel_button.frame.origin = {
            yq_cancel_button.frame.size = CGSize(width: frame.width, height: 45 * yq_scale)
            yq_cancel_button.backgroundColor = UIColor.yq_color(colorString: "FEFDFE")
            yq_cancel_button.setTitleColor(UIColor.yq_color(colorString: "#616161"), for: .normal)
            yq_cancel_button.titleLabel?.font = UIFont.systemFont(ofSize: 15 * yq_scale)
            yq_cancel_button.setTitle("取消", for: .normal)
            return CGPoint(x: 0, y: frame.height - yq_cancel_button.frame.height - yq_current_device.yq_tabBar_safe_height())
        }()
        
        yq_slow_7_5_button.frame.origin = {
            yq_slow_7_5_button.tag = Int(JY_Video_Speed.slow_7_5.rawValue * 100)
            yq_slow_7_5_button.isSelected = yq_currentSpeed == .slow_7_5
            yq_slow_7_5_button.frame.size = CGSize(width: frame.width, height: 44 * yq_scale)
            yq_slow_7_5_button.backgroundColor = UIColor.yq_color(colorString: "FEFDFE")
            yq_slow_7_5_button.setTitleColor(UIColor.yq_color(colorString: "#616161"), for: .normal)
            yq_slow_7_5_button.setTitleColor(UIColor.yq_color(colorString: "#3377FF"), for: .selected)
            yq_slow_7_5_button.titleLabel?.font = UIFont.systemFont(ofSize: 15 * yq_scale)
            yq_slow_7_5_button.setTitle("\(JY_Video_Speed.slow_7_5.rawValue)X", for: .normal)
            return CGPoint(x: 0, y: yq_cancel_button.frame.minY - yq_slow_7_5_button.frame.height - 10 * yq_scale)
        }()
        
        yq_normal_button.frame.origin = {
            yq_normal_button.tag = Int(JY_Video_Speed.normal.rawValue * 100)
            yq_normal_button.isSelected = yq_currentSpeed == .normal
            yq_normal_button.frame.size = CGSize(width: frame.width, height: 44 * yq_scale)
            yq_normal_button.backgroundColor = UIColor.yq_color(colorString: "FEFDFE")
            yq_normal_button.setTitleColor(UIColor.yq_color(colorString: "#616161"), for: .normal)
            yq_normal_button.setTitleColor(UIColor.yq_color(colorString: "#3377FF"), for: .selected)
            yq_normal_button.titleLabel?.font = UIFont.systemFont(ofSize: 15 * yq_scale)
            yq_normal_button.setTitle("\(JY_Video_Speed.normal.rawValue)X", for: .normal)
            return CGPoint(x: 0, y: yq_slow_7_5_button.frame.minY - yq_normal_button.frame.height - 1 * yq_scale)
        }()
        
        yq_fast_1_25_button.frame.origin = {
            yq_fast_1_25_button.tag = Int(JY_Video_Speed.fast_1_25.rawValue * 100)
            yq_fast_1_25_button.isSelected = yq_currentSpeed == .fast_1_25
            yq_fast_1_25_button.frame.size = CGSize(width: frame.width, height: 44 * yq_scale)
            yq_fast_1_25_button.backgroundColor = UIColor.yq_color(colorString: "FEFDFE")
            yq_fast_1_25_button.setTitleColor(UIColor.yq_color(colorString: "#616161"), for: .normal)
            yq_fast_1_25_button.setTitleColor(UIColor.yq_color(colorString: "#3377FF"), for: .selected)
            yq_fast_1_25_button.titleLabel?.font = UIFont.systemFont(ofSize: 15 * yq_scale)
            yq_fast_1_25_button.setTitle("\(JY_Video_Speed.fast_1_25.rawValue)X", for: .normal)
            return CGPoint(x: 0, y: yq_normal_button.frame.minY - yq_fast_1_25_button.frame.height - 1 * yq_scale)
        }()
        
        yq_fast_1_5_button.frame.origin = {
            yq_fast_1_5_button.tag = Int(JY_Video_Speed.fast_1_5.rawValue * 100)
            yq_fast_1_5_button.isSelected = yq_currentSpeed == .fast_1_5
            yq_fast_1_5_button.frame.size = CGSize(width: frame.width, height: 44 * yq_scale)
            yq_fast_1_5_button.backgroundColor = UIColor.yq_color(colorString: "FEFDFE")
            yq_fast_1_5_button.setTitleColor(UIColor.yq_color(colorString: "#616161"), for: .normal)
            yq_fast_1_5_button.setTitleColor(UIColor.yq_color(colorString: "#3377FF"), for: .selected)
            yq_fast_1_5_button.titleLabel?.font = UIFont.systemFont(ofSize: 15 * yq_scale)
            yq_fast_1_5_button.setTitle("\(JY_Video_Speed.fast_1_5.rawValue)X", for: .normal)
            return CGPoint(x: 0, y: yq_fast_1_25_button.frame.minY - yq_fast_1_5_button.frame.height - 1 * yq_scale)
        }()
        
        yq_fast_2_button.frame.origin = {
            yq_fast_2_button.tag = Int(JY_Video_Speed.fast_2_0.rawValue * 100)
            yq_fast_2_button.frame.size = CGSize(width: frame.width, height: 44 * yq_scale)
            let bgImage = UIImage.yq_generate_image(color: UIColor.yq_color(colorString: "FEFDFE"), imageSize: yq_fast_2_button.frame.size, cornerRadius: 10 * yq_scale, roundingCorners: [.topLeft, .topRight])
            
            yq_fast_2_button.setBackgroundImage(bgImage, for: .normal)
            yq_fast_2_button.setBackgroundImage(bgImage, for: .highlighted)
            
            yq_fast_2_button.isSelected = yq_currentSpeed == .fast_2_0
            yq_fast_2_button.setTitleColor(UIColor.yq_color(colorString: "#616161"), for: .normal)
            yq_fast_2_button.setTitleColor(UIColor.yq_color(colorString: "#3377FF"), for: .selected)
            yq_fast_2_button.titleLabel?.font = UIFont.systemFont(ofSize: 15 * yq_scale)
            yq_fast_2_button.setTitle("\(JY_Video_Speed.fast_2_0.rawValue)X", for: .normal)
            return CGPoint(x: 0, y: yq_fast_1_5_button.frame.minY - yq_fast_2_button.frame.height - 1 * yq_scale)
        }()
    }

}

extension JY_Video_Speed_Set_Alert_View {
    func yq_add_close_button_target(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        yq_cancel_button.addTarget(target, action: action, for: controlEvents)
    }
    
    func yq_add_speed_button_target(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        yq_fast_2_button.addTarget(target, action: action, for: controlEvents)
        yq_fast_1_5_button.addTarget(target, action: action, for: controlEvents)
        yq_fast_1_25_button.addTarget(target, action: action, for: controlEvents)
        yq_normal_button.addTarget(target, action: action, for: controlEvents)
        yq_slow_7_5_button.addTarget(target, action: action, for: controlEvents)
    }
}
