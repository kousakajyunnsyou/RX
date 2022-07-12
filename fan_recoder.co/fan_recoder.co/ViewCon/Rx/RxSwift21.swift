//
//  RxSwift21.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/7/4.
//  Copyright © 2022 yons. All rights reserved.
//  UI控件扩展1：UILabel

import UIKit
import RxSwift
import RxCocoa

class RxSwift21: BaseVCWithLableViewController {
    
    let disoseBag = DisposeBag()

    lazy var timeLable : UILabel = {[weak self] in
        let lable = self?.createLable()
        return lable!
    }()
    
    override func viewDidLoad() {
        lables.append(timeLable)
        //创建一个计时器（每0.1秒发送一个索引数）
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        //将已过去的时间格式化成想要的字符串，并绑定到label上
        timer.map(formatAttributedString(_:))
        .bind(to: timeLable.rx.attributedText)
        .disposed(by: disoseBag)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //将数字转成对应的富文本
    func formatAttributedString(_ par: NSInteger) -> NSMutableAttributedString {
        let str = String(format: "%0.2d:%0.2d.%0.1d", arguments: [(par/600) % 60,(par/10) % 60,par % 10 ])
        //富文本设置
        let attr = NSMutableAttributedString(string: str)
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attr.addAttribute(NSMutableAttributedString.Key.font,
                          value: UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
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
