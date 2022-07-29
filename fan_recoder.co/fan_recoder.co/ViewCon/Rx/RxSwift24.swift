//
//  RxSwift24ViewController.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/7/29.
//  Copyright © 2022 yons. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RxSwift24: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var lable: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //当 UISegmentedControl 选中项改变时，输出当前选中项标题
        segment.rx.selectedSegmentIndex.asObservable()
            .map{ self.segment.titleForSegment(at: $0)}
            .bind(to: lable.rx.text)
            .disposed(by: disposeBag)
    }
}

