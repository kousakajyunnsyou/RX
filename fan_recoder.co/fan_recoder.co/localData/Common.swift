//
//  Common.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/6/15.
//  Copyright © 2022 yons. All rights reserved.
//

import UIKit

class Common: NSObject {

}

//MARK: 全局通用属性

@available(iOS 13.0, *)
let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager

//状态栏高度
@available(iOS 13.0, *)
let KStatusBarH : CGFloat = statusBarManager?.statusBarFrame.size.height ?? 0

//导航栏高度
let KNavigationH : CGFloat = 44

//安全起始高度
let KSafeH = KStatusBarH + KNavigationH

//屏幕宽度
let KScreenWidth = UIScreen.main.bounds.width

//屏幕高度
let KScreenHeight = UIScreen.main.bounds.height
