//
//  ContentsTableSection.swift
//  fan_recoder.co
//
//  Created by yons on 2021/2/2.
//  Copyright © 2021 yons. All rights reserved.
//  目录画面tableView 的数据模型

import UIKit
import Foundation
import RxDataSources
import RxSwift
import RxCocoa

struct ContentsTableSection {
    
    var header: String
    var items: [Item]

}

extension ContentsTableSection : AnimatableSectionModelType {

    var identity: String {
        return header
    }

    typealias Item = TableDataModel

    init(original: ContentsTableSection, items: [Item]) {
        self = original
        self.items = items
    }
}

struct TableDataModel: Equatable {
    var name: String
    var storyBoard: String?
    var toView: String?
    var vc: UIViewController?
    
    init(name:String, storyBoard:String? = nil, toView:String? = nil, vc:UIViewController? = nil) {
        self.name = name
        self.storyBoard = storyBoard
        self.toView = toView
        self.vc = vc
    }
}

extension TableDataModel: IdentifiableType {
    typealias Identity = String
    var identity: Identity {
        return name
    }
}
