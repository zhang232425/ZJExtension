//
//  UIApplication+Extension.swift
//  Pods-ZJExtension_Example
//
//  Created by Jercan on 2022/10/28.
//

import Foundation

public extension UIApplication {
    
    /// 当前窗口
    static var window: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    /// 状态栏高度
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// 顶部栏高度
    static var safeAreaTop: CGFloat {
        guard #available(iOS 11.0, *), let height = UIApplication.window?.safeAreaInsets.top else {
            return 0
        }
        return height
    }
    
    /// 底部栏高度
    static var safeAreaBottom: CGFloat {
        guard #available(iOS 11.0, *), let height = UIApplication.window?.safeAreaInsets.bottom else {
            return 0
        }
        return height
    }
    
}
