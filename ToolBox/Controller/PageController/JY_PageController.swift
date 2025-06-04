//
//  JY_PageController.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/8.
//

import UIKit

open class JY_PageController: UIPageViewController {

    /** 即将翻动到下一页的block
     direction：翻页方向
     willPage：即将出现的页面
     */
    public var yq_will_scroll_page_block: ((_ direction: UIPageViewController.NavigationDirection, _ currentPage: Int, _ willPage: Int) -> Void)?
    
    /**
        页码变动的block
     */
    public var yq_page_index_block: ((_ index: Int) -> Void)?
    
    public lazy var yq_current_page_index: Int = 0 {
        didSet {
            yq_page_index_block?(yq_current_page_index)
        }
    }
        
    public lazy var yq_controller_array: [UIViewController] = [UIViewController]()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation)
        
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension JY_PageController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置数据源和委托
        dataSource = self
        delegate = self
    }
}
