//
//  JY_Normal_Transitioning_Delegate.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/8.
//

import UIKit

class JY_Normal_Transitioning_Delegate: NSObject, UIViewControllerTransitioningDelegate {
    /**
     返回一个用于管理视图控制器呈现样式的呈现控制器。呈现控制器负责管理被呈现视图控制器的布局和外观，如背景样式、尺寸等。若实现了该方法，需要返回一个 UIPresentationController 对象，或者返回 nil 表示使用系统默认的呈现控制器
     
     presented：即将被呈现的视图控制器。
     presenting：发起呈现操作的视图控制器，可能为 nil。
     source：发起呈现操作的源视图控制器。
     返回一个 UIPresentationController 对象，或者返回 nil 表示使用系统默认的呈现控制器。
     */
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JY_Normal_Present_Animator()
    }
    
    /**
     该方法为视图控制器的消失操作返回一个动画控制器。当一个视图控制器被消失时，系统会调用这个方法，若实现了该方法，就需要返回一个遵循 UIViewControllerAnimatedTransitioning 协议的对象，这个对象负责定义视图控制器消失时的动画效果。
     参数：
     dismissed：即将被消失的视图控制器。
     返回值：返回一个遵循 UIViewControllerAnimatedTransitioning 协议的对象，或者返回 nil 表示使用系统默认的动画
     */
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JY_Normal_Dismiss_Animator()
    }
}
