//
//  JY_PageController + DataSource.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/8.
//

import UIKit

extension JY_PageController: UIPageViewControllerDataSource {
    // 实现数据源方法，返回上一个页面
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = yq_controller_array.firstIndex(of: viewController) else {
            return nil
        }
        if currentIndex == 0 {
            return nil
        }
        return yq_controller_array[currentIndex - 1]
    }
    
    
    // 实现数据源方法，返回下一个页面
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = yq_controller_array.firstIndex(of: viewController) else {
            return nil
        }
        if currentIndex == yq_controller_array.count - 1 {
            return nil
        }
        return yq_controller_array[currentIndex + 1]
    }
}

extension JY_PageController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentVC = pageViewController.viewControllers?.first,
               let currentIndex = yq_controller_array.firstIndex(of: currentVC) {
//                print("当前显示的页面是: \(currentIndex + 1)")
                yq_current_page_index = currentIndex
            }
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let nextVC = pendingViewControllers.first, let nextIndex = yq_controller_array.firstIndex(of: nextVC) {
            if nextIndex > yq_current_page_index {
                yq_will_scroll_page_block?(.forward, yq_current_page_index, nextIndex)
//                print("即将向右翻页到第 \(nextIndex) 页")
            } else if nextIndex < yq_current_page_index {
                yq_will_scroll_page_block?(.reverse, yq_current_page_index, nextIndex)
//                print("即将向左翻页到第 \(nextIndex) 页")
            }
        }
    }
}
