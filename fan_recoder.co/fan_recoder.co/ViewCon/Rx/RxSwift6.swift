//
//  RxSwift6.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/6/21.
//  Copyright © 2022 yons. All rights reserved.
//  观察者2： 自定义可绑定属性

import UIKit
import RxCocoa
import RxSwift

class RxSwift6: BaseVCWithLableViewController {
    
    let disposeBag = DisposeBag()

    lazy var lableforExtension: UILabel = {
        let view = createLable()
        view.text = "对 UI 类进行扩展"
        return view
    }()
    
    lazy var lableforReactive: UILabel = {
        let view = createLable()
        view.text = "对Reactive进行扩展"
        return view
    }()

    override func viewDidLoad() {
        lables.append(lableforExtension)
        lables.append(lableforReactive)
        
        useExtension()
        useReactive()
        
        super.viewDidLoad()
    }
}

//MARK: RX事件，创建观察者
extension RxSwift6 {
    func useExtension() {
        let observer = Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
        observer.map { CGFloat($0).truncatingRemainder(dividingBy: 18.0) }
        .bind(to: lableforExtension.fontSize)
        .disposed(by: disposeBag)
    }
    
    func useReactive() {
        let observer = Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
        observer.map { CGFloat($0).truncatingRemainder(dividingBy: 18.0) }
        .bind(to: lableforReactive.rx.fontSize2)
        .disposed(by: disposeBag)
    }
}

/*通过对 UI 类进行扩展可绑定属性
 通过对 UILabel 进行扩展，增加了一个fontSize 可绑定属性
 **/
extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { lable, fontSize in
            lable.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

/*通过对 Reactive 类进行扩展
 更规范的写法应该是对 Reactive 进行扩展。这里同样是给 UILabel 增加了一个 fontSize 可绑定属性
 （注意：这种方式下，我们绑定属性时要写成 label.rx.fontSize）
*/
extension Reactive where Base: UILabel {
    public var fontSize2: Binder<CGFloat> {
        return Binder(self.base) { lable, fontSize in
            lable.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
