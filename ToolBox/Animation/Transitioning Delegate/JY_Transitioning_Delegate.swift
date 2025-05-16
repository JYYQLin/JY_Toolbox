//
//  JY_Transitioning_Delegate.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import UIKit

// 自定义转场动画类
class JY_Center_Present_Animator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)

        // 设置弹出控制器的大小
        toVC.view.frame = CGRect(x: 50, y: 100, width: containerView.bounds.width - 100, height: containerView.bounds.height - 200)
        toVC.view.alpha = 0

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toVC.view.alpha = 1
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}

// 转场代理类
class JY_Transitioning_Delegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JY_Center_Present_Animator()
    }
}
