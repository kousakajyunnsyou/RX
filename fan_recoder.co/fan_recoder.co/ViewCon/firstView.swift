//
//  firstView.swift
//  fan_recoder.co
//
//  Created by yons on 2021/1/11.
//  Copyright © 2021 yons. All rights reserved.
//  这是一个RxSwift UILable

import UIKit
import RxSwift
import RxCocoa

class firstView: ViewController{
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var rx_lable: UILabel!
    @IBOutlet weak var rx_textField: UITextField!
    @IBOutlet weak var rx_button: UIButton!
    
    override func viewDidLoad() {

        //创建了一个定时器，每0.1秒发送一个索引数
        /*******
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        timer.map(formatAttributedString)
            .bind(to: rx_lable.rx.attributedText)
            .disposed(by: disposeBag)
         *********/
        rx_textField.rx.text
            .bind(to: rx_lable.rx.text)
            .disposed(by: disposeBag)
        rx_button.rx.tap
            .subscribe(onNext: {
                self.rx_lable.text = nil
                self.rx_textField.text = nil
            })
            .disposed(by: disposeBag)
        let a = UITapGestureRecognizer.init()
        
    }
    
    @IBAction func aaaa(_ sender: UITapGestureRecognizer) {
        print("手势")
    }
    //将数字转成对应的富文本
    func formatAttributedString(_ par: NSInteger) -> NSMutableAttributedString {
        let str = String(format: "%0.2d:%0.2d.%0.1d", arguments: [(par/600) % 60,(par/10) % 60,par % 10 ])
        //富文本设置
        let attr = NSMutableAttributedString(string: str)
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attr.addAttribute(NSMutableAttributedString.Key.font,
                          value: UIFont(name: "HelveticaNeue-Bold", size: 16),
                          range: NSMakeRange(0, 5))
        //设置字体颜色
        attr.addAttribute(NSMutableAttributedString.Key.foregroundColor,
                          value: UIColor.white,
                          range: NSMakeRange(0, 5))
        //设置文字背景颜色
        attr.addAttribute(NSMutableAttributedString.Key.backgroundColor,
                          value: UIColor.red,
                          range: NSMakeRange(0, 5))
        return attr
        
    }
    
   
}

extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { lable, fontSize in
            lable.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
