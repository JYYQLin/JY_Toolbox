//
//  JY_Video_Speed_Set_Alert_Controller.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/27.
//

import UIKit

class JY_Video_Speed_Set_Alert_Controller: JY_Base_Controller {

    private lazy var yq_alert_view: JY_Video_Speed_Set_Alert_View = {
        let view = JY_Video_Speed_Set_Alert_View()
        
        view.yq_add_close_button_target(self, action: #selector(yq_close_click), for: .touchUpInside)
        view.yq_add_speed_button_target(self, action: #selector(yq_speed_click(button:)), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var yq_is_show: Bool = false
    
    @objc private func yq_close_click() {
        self.yq_hidden()
    }
    
    @objc private func yq_speed_click(button: UIButton) {
        let speed = JY_Video_Speed(rawValue: Float(button.tag) / 100.0) ?? .normal
        yq_alert_view.yq_set(currentSpeed: speed)
        
        yq_hidden { [weak self] in
            if self != nil && self?.yq_speed_click_block != nil {
                self!.yq_speed_click_block!(speed)
            }
        }
        
    }
    
    var yq_speed_click_block: ((_ currentSpeed: JY_Video_Speed) -> Void)?
    
    init(currentSpeed: JY_Video_Speed) {
        super.init(nibName: nil, bundle: nil)
        
        yq_alert_view.yq_set(currentSpeed: currentSpeed)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JY_Video_Speed_Set_Alert_Controller {
    override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_content_view.addSubview(yq_alert_view)
    }
    
    override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_background_content_view.backgroundColor = UIColor.yq_color(colorString: "#3d3d3d").withAlphaComponent(0.51)
        
        yq_alert_view.frame.origin = {
            
            yq_alert_view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            yq_alert_view.frame.size = CGSize(width: yq_content_view.frame.width, height: (45 * 6 + 10) * yq_scale + yq_current_device.yq_tabBar_safe_height())
            
            
            let y = yq_is_show == true ? (yq_content_view.frame.height - yq_alert_view.frame.height) : yq_content_view.frame.height
            yq_alert_view.yq_set(scale: yq_scale)
            
            yq_alert_view.alpha = yq_is_show == false ? 0 : 1
            
            return  CGPoint(x: (yq_content_view.frame.width - yq_alert_view.frame.width) * 0.5, y: y)
        }()
        
        if view.frame.width > 0 && view.frame.height > 0 {
            yq_show()
        }
    }
}

extension JY_Video_Speed_Set_Alert_Controller {
    private func yq_show() {
        if yq_is_show == true {
            return
        }
        
        UIView.animate(withDuration: CATransaction.animationDuration()) { [weak self] in
            self?.yq_alert_view.alpha = 1
            self?.yq_alert_view.frame.origin.y = (self?.yq_content_view.frame.height ?? 0) - (self?.yq_alert_view.frame.height ?? 0)
        } completion: { [weak self] _ in
            self?.yq_is_show = true
        }
    }
    
    private func yq_hidden(completion: (() -> Void)? = nil) {
        
        UIView.animate(withDuration: CATransaction.animationDuration()) { [weak self] in
            self?.yq_alert_view.alpha = 0
            self?.yq_alert_view.frame.origin.y = (self?.yq_content_view.frame.height ?? 0)
        } completion: { [weak self] _ in
            self?.yq_is_show = false
            self?.dismiss(animated: false)
            
            if completion != nil {
                completion!()
            }
        }
    }
}

extension JY_Video_Speed_Set_Alert_Controller {
    static func yq_show(_ fromController: UIViewController, currentSpeed: JY_Video_Speed, speedClickBlock: ((_ currentSpeed: JY_Video_Speed) -> Void)?) {
        
        let controller = JY_Video_Speed_Set_Alert_Controller(currentSpeed: currentSpeed)
        controller.modalPresentationStyle = .custom
        controller.yq_speed_click_block = speedClickBlock
        fromController.present(controller, animated: false)
    }
}
