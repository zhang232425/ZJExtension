//
//  UINavigationBar+Extension.swift
//  Pods-ZJExtension_Example
//
//  Created by Jercan on 2022/10/28.
//

import Foundation

public extension UINavigationBar {

    /// 导航栏高度
    static var navBarHeight: CGFloat {
        return UINavigationController().navigationBar.frame.height
    }
    
    /// 状态导航栏高度
    static var statusNavBarHeight: CGFloat {
        return navBarHeight + UIApplication.statusBarHeight
    }
    
}
