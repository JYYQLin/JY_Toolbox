//
//  JY_Drag_Dismiss_Interactive.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/8.
//

import UIKit

class JY_Drag_Dismiss_Interactive: UIPercentDrivenInteractiveTransition {
    
    // 交互是否开始
    fileprivate var yq_is_interaction_started = false
    // 交互是否即将完成
    fileprivate var yq_is_interaction_should_finish = false
    fileprivate var yq_from_controller: UIViewController?
    
    /** 拖拽完成度阈值，完成度大于阈值则开始自动完成 */
    open var yq_interaction_threshold: CGFloat = 0.5
    
    /** 拖拽方向 */
    open var yq_swipe_direction: JY_Drag_Dismiss_Swipe_Direction = .down
}

extension JY_Drag_Dismiss_Interactive {
    public func attach(to: UIViewController) {
        yq_from_controller = to
        yq_from_controller?.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:))))
        if #available(iOS 10.0, *) {
            wantsInteractiveStart = false
        }
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        guard let controller = yq_from_controller, let view = controller.view else { return }
        
        let translation = gesture.translation(in: controller.view.superview)
        
        let delta = yq_swipe_direction.rawValue * (translation.y / view.bounds.height)
        let movement = fmaxf(Float(delta), 0.0)
        let percent = fminf(movement, 1.0)
        let progress = CGFloat(percent)
        
        switch gesture.state {
        case .began:
            yq_is_interaction_started = true
            controller.dismiss(animated: true, completion: nil)
        case .changed:
            yq_is_interaction_should_finish = progress > yq_interaction_threshold
            update(progress)
        case .cancelled:
            yq_is_interaction_should_finish = false
            fallthrough
        case .ended:
            yq_is_interaction_started = false
//            yq_is_interaction_should_finish ? finish() : cancel()
            cancel()
        default:
            break
        }
    }
}

