//
//  JY_PageController + Set.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/8.
//

import UIKit

extension JY_PageController {
    
    public func yq_set(pageIndex: Int, direction: UIPageViewController.NavigationDirection? = nil) {
                
        guard pageIndex >= 0 && pageIndex < yq_controller_array.count else {
            return
        }
        
        if pageIndex == yq_current_page_index {
            return
        }
        
        let targetVC = yq_controller_array[pageIndex]
        
        if direction != nil {
            setViewControllers([targetVC], direction: direction!, animated: true, completion: nil)
        }
        else{
            
            if pageIndex == yq_current_page_index {
                
            }
            else if pageIndex < yq_current_page_index {
                setViewControllers([targetVC], direction: .reverse, animated: true, completion: nil)

            }
            else{
                setViewControllers([targetVC], direction: .forward, animated: true, completion: nil)
            }
        }
        
        yq_current_page_index = pageIndex
    }
}

extension JY_PageController {
    
    public func yq_set(controllerArray: [UIViewController]) {
        yq_controller_array = controllerArray
        
        if let firstVC = yq_controller_array.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    public func yq_add(controllerArray: [UIViewController], autoScroll: Bool = false) {
        yq_controller_array = yq_controller_array + controllerArray
        
        if autoScroll == true, let firstVC = controllerArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    public func yq_inset(controllerArray: [UIViewController], autoScroll: Bool = false) {
        yq_controller_array = controllerArray + yq_controller_array
        
        if autoScroll == true, let firstVC = controllerArray.last {
            setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
        }
    }
}
