//
//  UIButton+.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/7/26.
//  Copyright © 2022 yons. All rights reserved.
//

import UIKit

extension UIButton {
    //提供一个默认的按钮样式
    func defaultButton() -> UIButton {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("按钮", for: .normal)
        btn.setTitleColor(.link, for: .normal)
        btn.setTitleColor(.gray, for: .disabled)
        btn.setTitleColor(.red, for: .selected)
        btn.layer.cornerRadius = 15
        return btn
    }
}
