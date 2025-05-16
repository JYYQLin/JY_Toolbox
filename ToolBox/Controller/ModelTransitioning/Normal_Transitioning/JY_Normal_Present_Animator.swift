//
//  JY_Normal_Present_Animator.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/8.
//

import UIKit

class JY_Normal_Present_Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return CATransaction.animationDuration()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        //  设置起始位置
//        toViewController.view.frame.origin.x = containerView.bounds.width
        toViewController.view.frame.origin.y = -containerView.bounds.height
        
        //  设置弹出动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//            toViewController.view.frame.origin.x = 0
            toViewController.view.frame.origin.y = 0
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
