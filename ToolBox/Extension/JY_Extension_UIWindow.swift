//
//  JY_Extension_UIWindow.swift
//  JY_ToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

extension UIWindow {
    public static func yq_first_window() -> UIWindow? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window
    }
}
