//
//  RxSwift25.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/7/29.
//  Copyright © 2022 yons. All rights reserved.
//  UI控件扩展5：UIActivityIndicatorView、UIApplication

import UIKit
import RxSwift
import RxCocoa

class RxSwift25: UIViewController {

    @IBOutlet weak var switchForIndicator: UISwitch!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var switchForUIApplication: UISwitch!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UIActivityIndicatorView 又叫状态指示器，它会通过一个旋转的“菊花”来表示当前的活动状态。
        //通过开关我们可以控制活动指示器是否显示旋转。
        switchForIndicator.rx.isOn
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        //RxSwift 对 UIApplication 增加了一个名为 isNetworkActivityIndicatorVisible 绑定属性，我们通过它可以设置是否显示联网指示器（网络请求指示器）。
        //当开关打开时，顶部状态栏上会有个菊花状的联网指示器。
        //当开关关闭时，联网指示器消失。
        switchForUIApplication.rx.value
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
    }
    

}
