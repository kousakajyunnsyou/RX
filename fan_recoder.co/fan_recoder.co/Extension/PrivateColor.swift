//
//  PrivateColor.swift
//  fan_recoder.co
//
//  Created by yons on 2021/1/14.
//  Copyright © 2021 yons. All rights reserved.
//

import UIKit

extension UIColor {
    
    //对16进制进行转码的便利方法
    fileprivate static func UIColorFromRGB(_ rgbValue: UInt, alpha:CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    static func testColor() -> UIColor {
        return UIColorFromRGB(0x849827, alpha: 1.0)
    }
    
    static func secondaryPrimaryColor() -> UIColor {
        return UIColorFromRGB(0x727272, alpha: 1.0)
    }
    

}
