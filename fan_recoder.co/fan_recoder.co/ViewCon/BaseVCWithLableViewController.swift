//
//  BaseVCWithLableViewController.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/6/28.
//  Copyright © 2022 yons. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseVCWithLableViewController: UIViewController {

    var lables: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for lable in lables {
            view.addSubview(lable)
        }
        // Do any additional setup after loading the view.
    }
}

extension BaseVCWithLableViewController {
    //创建默认Lable
    func createLable() -> UILabel {
        let margin: CGFloat = CGFloat(lables.count * 50)
        
        let view = UILabel()
        view.frame.size = CGSize(width: 200, height: 40)
        view.center = CGPoint(x: KScreenWidth/2, y: KSafeH + 30 + margin)
        //宽高自适应
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.layer.borderColor = CGColor(red: 0, green: 122, blue: 255, alpha: 1)
        view.layer.borderWidth = 0.5
        
        //设置圆角
        view.layer.cornerRadius = 25
        
        //文字居中
        view.textAlignment = .center
        return view
    }
}
