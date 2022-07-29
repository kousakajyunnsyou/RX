//
//  RxSwift23.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/7/22.
//  Copyright © 2022 yons. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

let KSimpleViewH: CGFloat = 200

class RxSwift23: UIViewController {
    
    let disposeBag = DisposeBag()
    
    //MARK: 例子
    let baseView: UIScrollView = {
       let view = UIScrollView()
        view.frame = CGRect(x: 0, y: KSafeH, width: KScreenWidth, height: KScreenHeight - KSafeH)
        view.contentSize = CGSize(width: KScreenWidth, height: KScreenHeight + 200)
        view.backgroundColor = .gray
        return view
    }()
    
    //例1：按钮点击响应
    lazy var view1: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KSimpleViewH))
        view.backgroundColor = .lightGray
        
        let lab = UILabel(frame: CGRect(x: 8, y: 8, width: 50, height: 20))
        lab.text = "例1"
        view.addSubview(lab)
        
        let btn: UIButton = UIButton().defaultButton()
        btn.frame.size = CGSize(width: 80, height: 40)
        btn.center = view.center
        view.addSubview(btn)
        
        //按钮的点击事件
        btn.rx.tap.subscribe(onNext: {[weak self] in
            self?.showMessage("按钮被点击")
        }).disposed(by: disposeBag)
        
        return view
    }()
    
    //例2：按钮基础属性变更
    lazy var view2: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: KSimpleViewH * 1, width: KScreenWidth, height: KSimpleViewH))
        view.backgroundColor = .systemBrown
        
        let lab = UILabel(frame: CGRect(x: 8, y: 8, width: 50, height: 20))
        lab.text = "例2"
        view.addSubview(lab)
        
        let btn: UIButton = UIButton().defaultButton()
        btn.frame.size = CGSize(width: 80, height: 40)
        btn.center = CGPoint(x: KScreenWidth / 2, y: KSimpleViewH / 2)
        view.addSubview(btn)
        
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        /**btn 其它可观察属性↓
         button.rx.title :　按钮标题
         button.rx.attributedTitle() ：按钮富文本标题
         button.rx.image(): 按钮图标
         button.rx.backgroundImage():  按钮背景图片
        */
        timer.map{"计数\($0)"}
        .bind(to: btn.rx.title(for: .normal))
        .disposed(by: disposeBag)
        
        return view
    }()
    
    //例3：切换开关UISwitch 与 按钮是否可用（isEnabled）
    lazy var view3: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: KSimpleViewH * 2, width: KScreenWidth, height: KSimpleViewH))
        view.backgroundColor = .white
        
        let lab = UILabel(frame: CGRect(x: 8, y: 8, width: 50, height: 20))
        lab.text = "例3"
        view.addSubview(lab)
        
        let switchBtn: UISwitch = UISwitch()
        switchBtn.frame = CGRect(x: KScreenWidth / 4, y: KSimpleViewH / 2, width: 80, height: 40)
        view.addSubview(switchBtn)
        
        let btn: UIButton = UIButton().defaultButton()
        btn.frame.size = CGSize(width: 80, height: 40)
        btn.center = CGPoint(x: KScreenWidth / 4 * 3, y: KSimpleViewH / 2)
        view.addSubview(btn)
        
        //切换开关（UISwitch）时，button 会在可用和不可用的状态间切换
        switchBtn.rx.isOn.bind(to: btn.rx.isEnabled).disposed(by: disposeBag)
        
        return view
    }()
    
    //例4：按钮是否选中（isSelected）
    lazy var view4: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: KSimpleViewH * 3, width: KScreenWidth, height: KSimpleViewH))
        view.backgroundColor = .orange
        
        let lab = UILabel(frame: CGRect(x: 8, y: 8, width: 50, height: 20))
        lab.text = "例4"
        view.addSubview(lab)
        
        let btn1: UIButton = UIButton().defaultButton()
        btn1.frame.size = CGSize(width: 80, height: 40)
        btn1.center = CGPoint(x: 40, y: KSimpleViewH / 2)
        btn1.setTitle("按钮1", for: .normal)
        btn1.isSelected = true
        
        let btn2: UIButton = UIButton().defaultButton()
        btn2.frame.size = CGSize(width: 80, height: 40)
        btn2.center = CGPoint(x: 160, y: KSimpleViewH / 2)
        btn2.setTitle("按钮2", for: .normal)
        
        let btn3: UIButton = UIButton().defaultButton()
        btn3.frame.size = CGSize(width: 80, height: 40)
        btn3.center = CGPoint(x: 280, y: KSimpleViewH / 2)
        btn3.setTitle("按钮3", for: .normal)
        
        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
        
        let btns = [btn1, btn2, btn3]
        //创建一个可观察序列，它可以发送最后一次点击的按钮（也就是需要选中的按钮）
        let selectBtn = Observable.from(
            btns.map({ btn in
                btn.rx.tap.map{btn}
            })
        ).merge()
        
        //对于每一个按钮都对selectedButton进行订阅，根据它是否是当前选中的按钮绑定isSelected属性
        for btn in btns {
            selectBtn.map{ $0 == btn}
            .bind(to: btn.rx.isSelected)
            .disposed(by: disposeBag)
        }
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.addSubview(view1)
        baseView.addSubview(view2)
        baseView.addSubview(view3)
        baseView.addSubview(view4)
        view.addSubview(baseView)
    }
    
}

//MARK: 辅助用方法
extension RxSwift23 {
    //通过对话框显示消息
    func showMessage(_ text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
