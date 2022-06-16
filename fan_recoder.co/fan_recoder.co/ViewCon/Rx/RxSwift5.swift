//
//  RxSwiftViewController.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/6/15.
//  Copyright © 2022 yons. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwift5: UIViewController {
    
    let disposeBag = DisposeBag()

    var lables: [UILabel] = []
    
    lazy var lableforBind: UILabel = {
        let view = createLable()
        return view
    }()
    
    lazy var lableforAnyObserver: UILabel = {
        let view = createLable()
        return view
    }()
    
    lazy var lableforBinder: UILabel = {
        let view = createLable()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()

        useBind()
        useAnyObserver()
        useBinder()
    }

}

//MARK: RX事件，创建观察者
extension RxSwift5 {
    //在 bind 方法中创建观察者
    /**
     创建观察者最直接的方法就是在 Observable 的 subscribe 方法后面描述当事件发生时，需要如何做出响应。
     */
    func useBind() {
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        observable
            .map {"当前索引数: \($0)"}
            .bind {[weak self]text in
                self?.lableforBind.text = text
            }.disposed(by: disposeBag)
    }
    
    //使用 AnyObserver 创建观察者
    /**
     AnyObserver 可以用来描叙任意一种观察者。
     */
    func useAnyObserver() {
        let observer: AnyObserver<String> = RxSwift.AnyObserver {[weak self] event in
            switch event {
            case .next(let text):
                self?.lableforAnyObserver.text = text
            default:
                break
            }
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.8, scheduler: MainScheduler.instance)
        observable
            .map {"当前索引数: \($0)"}
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
    
    //使用 Binder 创建观察者
    /**
     相较于AnyObserver 的大而全，Binder 更专注于特定的场景。Binder 主要有以下两个特征：

     不会处理错误事件
     确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
     
     label 标签的文字显示就是一个典型的 UI 观察者。它在响应事件时，只会处理 next 事件，而且更新 UI 的操作需要在主线程上执行。那么这种情况下更好的方案就是使用 Binder。
     */
    func useBinder() {
        let observer: Binder<String> = Binder(lableforBinder) { (view, text) in
            view.text = text
        }
        
        let observable = Observable<Int>.interval(0.6, scheduler: MainScheduler.instance)
        observable
            .map {"当前索引数: \($0)"}
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
}

//MARK: 更新UI
extension RxSwift5 {
    func setUpUI() {
        lables.append(lableforBind)
        lables.append(lableforAnyObserver)
        lables.append(lableforBinder)
        
        for lable in lables {
            view.addSubview(lable)
        }
    }
    
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
        
        return view
    }
}
