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
                                         TableDataModel(name: "UI控件扩展1：UILabel", vc: RxSwift21()),
                                         TableDataModel(name: "UI控件扩展2：UITextField、UITextView", storyBoard: "RxSwiftStoryBoard", toView: "RxSwift22"),
                                         TableDataModel(name: "UI控件扩展3：UIButton、UIBarButtonItem", vc: RxSwift23()),
                                         TableDataModel(name: "UI控件扩展4：UISegmentedControl", storyBoard: "RxSwiftStoryBoard", toView: "RxSwift24"),
                                         TableDataModel(name: "UI控件扩展5：UIActivityIndicatorView、UIApplication", storyBoard: "RxSwiftStoryBoard", toView: "RxSwift25"),
                                         TableDataModel(name: "UI控件扩展6：UISlider、UIStepper", storyBoard: "RxSwiftStoryBoard", toView: "RxSwift26"),
                                         TableDataModel(name: "UI控件扩展7：UIGestureRecognizer", vc: RxSwift28()),
                                         TableDataModel(name: "UI控件扩展8：UIDatePicker", storyBoard: "RxSwiftStoryBoard", toView: "RxSwift29"),
                                         TableDataModel(name: "UITableView的使用1：基本用法", vc: RxSwift30()),
                                         TableDataModel(name: "表格的使用", storyBoard: "RxtableViewController", toView: "RxtableViewController"),
                                         TableDataModel(name: "暂不可用"),
                                         TableDataModel(name: "测试用",storyBoard: "TestView", toView: "TestView")]
}
