//
//  RxSwift28.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/7/30.
//  Copyright © 2022 yons. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwift28: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //添加一个上滑手势
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        
        //手势响应
        swipe.rx.event
        //在这里使用bind也是可以的（subscribe->bind)
            .subscribe(onNext: {[weak self] gesture in
                //这个点是滑动的起点
                let point = gesture.location(in: gesture.view)
                self?.showAlert(title: "向上滑动", message: "(\(point.x),\(point.y))")
            }).disposed(by: disposeBag)
        
    }
}

//MARK: 辅助方法
extension RxSwift28 {
    //依据信息来展示一个对话框
    fileprivate func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}
