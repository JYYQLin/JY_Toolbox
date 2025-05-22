//
//  JY_TabBar_Controller.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/24.
//

import UIKit

public typealias JY_TabBar_Theme_Type = (font: UIFont, normalTextColor: UIColor, selectedColor: UIColor, tabBarBackgroundColor: UIColor?)

open class JY_TabBar_Controller: UITabBarController {
    public lazy var yq_tabBar_item_data: [(title: String, controllerID: String, controller: UINavigationController)] = [(title: String, controllerID: String, controller: UINavigationController)]()
    
    private(set) lazy var yq_tabBar_item_theme: JY_TabBar_Theme_Type = (font: UIFont.yq_semibold_font(10), normalTextColor: UIColor(named: "JY_TabBar_normal_textColor") ?? UIColor.yq_random(), selectedColor: UIColor(named: "JY_TabBar_selected_textColor") ?? UIColor.yq_random(), tabBarBackgroundColor: UIColor(named: "JY_TabBar_bgColor"))
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension JY_TabBar_Controller {
    public func yq_set(tabBarItemTheme theme: JY_TabBar_Theme_Type) {
        yq_tabBar_item_theme = theme
        yq_set_tabBarFrame()
    }
}

extension JY_TabBar_Controller {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        /// 添加子控制器
        yq_add_childs_controller()
        
        self.delegate = self
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        yq_set_tabBarFrame()
        
        if (self.tabBar.items?.count ?? 0) > 0 {
            for (index, item) in self.tabBar.items!.enumerated() {
                if index < yq_tabBar_item_data.count {
                    item.title = yq_tabBar_item_data[index].title.yq_localized(tableName: "JY_TabBar")
                }
            }
        }
    }
}

extension JY_TabBar_Controller {
    @objc func yq_set_tabBarFrame() {
        let tabBarFont = yq_tabBar_item_theme.font
        let tabBarTextColorNormal = yq_tabBar_item_theme.normalTextColor
        let tabBarTextColorSelected = yq_tabBar_item_theme.selectedColor
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tabBarTextColorNormal, NSAttributedString.Key.font: tabBarFont]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tabBarTextColorSelected, NSAttributedString.Key.font: tabBarFont]
        
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance = tabBarItemAppearance
        
        if yq_tabBar_item_theme.tabBarBackgroundColor != nil {
            appearance.backgroundColor = yq_tabBar_item_theme.tabBarBackgroundColor!
        }
        
        self.tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        } else {
            
        }
    }
}

extension JY_TabBar_Controller: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        var currentIndex = -1
        
        for (index, controller) in self.children.enumerated() {
            if viewController == controller {
                currentIndex = index
                break
            }
        }
        
        // 选中TabBarItem后发送该控制器的序号
        JY_TabBar_Controller.yq_post_tabBarController_didSelect_notification(object: currentIndex)
    }
}

public extension JY_TabBar_Controller {
    func yq_select_controller(index: Int) {
        
        if index < self.children.count {
            selectedViewController = children[index]
        }
    }
    
    func yq_select_first_controller() {
        selectedViewController = children.first
    }
    
    func yq_select_last_controller() {
        selectedViewController = children.last
    }
}

extension JY_TabBar_Controller {
    @objc open func yq_add_childs_controller() {
        
        yq_tabBar_item_data = [(title: String, controllerID: String, controller: UINavigationController)]()
    }
    
    public func yq_set_navigation_controller(tabBarImageNameNormal: String, tabBarImageNameSelected: String, tabBarTitleText: String, controller: UIViewController, controllerName: String) -> JY_Navigation_Controller {
        
        let navigationController = JY_Navigation_Controller(rootViewController: controller)
        
        yq_tabBar_item_data.append((title: tabBarTitleText, controllerID: controllerName, controller: navigationController))
        
        navigationController.tabBarItem.image = UIImage(named: tabBarImageNameNormal)
        navigationController.tabBarItem.selectedImage = UIImage(named: tabBarImageNameSelected)
        
        return navigationController
    }
}
