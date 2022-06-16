//
//  TestView.swift
//  fan_recoder.co
//
//  Created by yons on 2021/1/19.
//  Copyright © 2021 yons. All rights reserved.
//  这里有一个按钮，放一些函数并测试它的用法。并不作为常态保存

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class TestView: ViewController {
    
   
    @IBOutlet weak var rx_event: UIButton!
    let rxTest = Combining_Obseravles()
    let deleteTest = DeleteClass()
    
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func event(_ sender: Any) {
        DeleteClass.test()
    }
}

