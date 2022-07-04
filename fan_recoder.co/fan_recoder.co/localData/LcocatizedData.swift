//
//  LcocatizedData.swift
//  fan_recoder.co
//
//  Created by yons on 2021/1/30.
//  Copyright © 2021 yons. All rights reserved.
//

import UIKit

class LcocatizedData: NSObject {

    
    //提供表格内容 -> RxTableView.swift
    
    static var meun: [TableDataModel] = [TableDataModel(name: "观察者1： AnyObserver、Binder", vc: RxSwift5()),
                                         TableDataModel(name: "观察者2： 自定义可绑定属性", vc: RxSwift6()),
                                         TableDataModel(name: "表格的使用", toView: "RxtableViewController"),
                                         TableDataModel(name: "暂不可用"),
                                         TableDataModel(name: "测试用", toView: "TestView")]
}
