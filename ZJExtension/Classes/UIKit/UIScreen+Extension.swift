//
//  UIScreen+Extension.swift
//  Pods-ZJExtension_Example
//
//  Created by Jercan on 2022/10/28.
//

import Foundation

public extension UIScreen {
    
    /// 状态栏高度
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// 顶部安全距离高度
    static var safeAreaTop: CGFloat {
        guard #available(iOS 11.0, *), let height = UIApplication.shared.keyWindow?.safeAreaInsets.top else {
            return 0
        }
        return height
    }
    
    /// 底部栏高度
    static var safeAreaBottom: CGFloat {
        guard #available(iOS 11.0, *), let height = UIApplication.shared.keyWindow?.safeAreaInsets.bottom else {
            return 0
        }
        return height
    }
    
    /// 导航栏高度
    static var navBarHeight: CGFloat {
        return UINavigationController().navigationBar.frame.height
    }
    
    /// tabbar高度
    static var tabBarHeight: CGFloat {
        return UITabBarController().tabBar.frame.height
    }
    
}
