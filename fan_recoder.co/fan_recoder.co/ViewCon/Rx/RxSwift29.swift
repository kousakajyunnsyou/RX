//
//  RxSwift29.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/8/2.
//  Copyright © 2022 yons. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RxSwift29: UIViewController {

    @IBOutlet weak var datePicter: UIDatePicker!
    @IBOutlet weak var timeLable: UILabel!
    
    lazy var dateFormater: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日 HH:mm"
        return df
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicter.rx.date
            .map{[weak self] in
                "当前选择时间:\n" + self!.dateFormater.string(from: $0)
            }
            .bind(to: timeLable.rx.text)
            .disposed(by: disposeBag)
        
    }

}
