//
//  RxSwift23.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/7/22.
//  Copyright © 2022 yons. All rights reserved.
//

import Foundation
import UIKit

class RxSwift23: UIViewController {
    
    let baseView: UIScrollView = {
       let view = UIScrollView()
        view.frame = CGRect(x: 0, y: KSafeH, width: KScreenWidth, height: KScreenHeight - KSafeH)
        view.contentSize = CGSize(width: KScreenWidth, height: KScreenHeight + 200)
        view.backgroundColor = .gray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(baseView)
    }
    
}
