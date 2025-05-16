//
//  JY_PageCurl_PageController.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/8.
//

import UIKit

class JY_PageCurl_PageController: JY_PageController {

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .pageCurl, navigationOrientation: navigationOrientation)
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
