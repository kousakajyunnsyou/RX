//
//  RxSwift26.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/7/29.
//  Copyright © 2022 yons. All rights reserved.
//  UI控件扩展6：UISlider、UIStepper

import UIKit
import RxCocoa
import RxSwift

class RxSwift26: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var stepper: UIStepper!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //当拖动滑块时，在控制台中实时输出 slider 当前值。
        slider.rx.value.asObservable()
            .subscribe(onNext: {
                DebugLog.D("滑块当前进度：\($0)")
            }).disposed(by: disposeBag)
        
        //当 stepper 值改变时，在控制台中实时输出当前值。
        stepper.rx.value.asObservable()
            .subscribe(onNext: {
                DebugLog.D("计步器当前进度：\($0)")
            }).disposed(by: disposeBag)
        
        //使用滑块（slider）来控制 stepper 的步长(stepper 的步长必须大于0)
        slider.rx.value.map{ $0 > 0 ? Double($0) : 0.1 }
        .bind(to: stepper.rx.stepValue)
        .disposed(by: disposeBag)
    }

}
