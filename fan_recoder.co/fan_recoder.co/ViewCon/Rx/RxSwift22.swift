//
//  RxSwift22.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/7/12.
//  Copyright © 2022 yons. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwift22: UIViewController {

    let disposeBag = DisposeBag()
    
    //例1
    @IBOutlet weak var textField1: UITextField!
    //例2
    @IBOutlet weak var textField2_1: UITextField!
    @IBOutlet weak var textField2_2: UITextField!
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var button2: UIButton!
    //例3
    @IBOutlet weak var textField3_1: UITextField!
    @IBOutlet weak var textField3_2: UITextField!
    @IBOutlet weak var lable3: UILabel!
    //例4
    @IBOutlet weak var textField4_1: UITextField!
    @IBOutlet weak var textField4_2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //------------------------例1：监听单个 textField 内容的变化
        //[change] 与 [asObservable()] 具有相同的效果
        textField1.rx.text.orEmpty.changed
            .subscribe(onNext: {
                ////当文本框内容改变时，将内容输出到控制台上
                print("现在输入的是： \($0)")
            }).disposed(by: disposeBag)
        
        //------------------------例2：将内容绑定到其他控件上
        let input = textField2_1.rx.text.orEmpty.asDriver().throttle(0.5)
        
        input.drive(textField2_2.rx.text).disposed(by: disposeBag)
        input.map{ "当前文字数： \($0.count)"}.drive(lable2.rx.text).disposed(by: disposeBag)
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5 }.drive(button2.rx.isEnabled).disposed(by: disposeBag)
        
        //------------------------例3：同时监听多个 textField 内容的变化
        Observable.combineLatest(textField3_1.rx.text.orEmpty, textField3_2.rx.text.orEmpty) { (area, num) -> String in
            return "你输入的号码是：\(area)-\(num)"
        }
        .bind(to: lable3.rx.text)
        .disposed(by: disposeBag)
        
        //------------------------例4：通过 rx.controlEvent 可以监听输入框的各种事件，且多个事件状态可以自由组合。
        /*
         除了各种 UI 控件都有的 touch 事件外，输入框还有如下几个独有的事件：

         editingDidBegin：开始编辑（开始输入内容）
         editingChanged：输入内容发生改变
         editingDidEnd：结束编辑
         editingDidEndOnExit：按下 return 键结束编辑
         allEditingEvents：包含前面的所有编辑相关事件
         */
        //在用户名输入框中按下 return 键，密码框获得焦点
        textField4_1.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {[weak self] in
            self?.textField4_2.becomeFirstResponder()
        }).disposed(by: disposeBag)
        //在密码输入框中按下 return 键，密码框移除焦点
        textField4_2.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {[weak self] in
            self?.textField4_2.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
}
