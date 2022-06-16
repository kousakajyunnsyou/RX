//
//  ContentsTableViewModel.swift
//  fan_recoder.co
//
//  Created by yons on 2021/3/12.
//  Copyright © 2021 yons. All rights reserved.
//

import Foundation

enum TableEditingCommand {
    case setItems(items: [String])                   //设置表格数据
    case addItems(items: [String])                   //增加数据
    case moveItem(from: IndexPath, to: IndexPath)    //移动数据项
    case deleteItem(for: IndexPath)                  //删除数据项
}

struct ContentsTableViewModel {
    
    private let TAG = "ContentsTableViewModel"
    
    //表格的数据项
    fileprivate var items: [String]
    
    init(items: [String]) {
        self.items = items
    }
    
    func execute(command: TableEditingCommand) -> ContentsTableViewModel {
        switch command {
        case .setItems(let items):
            return ContentsTableViewModel(items: items)
        case .addItems(let addItems):
            var items = self.items
            items = items + addItems
            return ContentsTableViewModel(items: items)
        case .moveItem(let from, let to):
            var items = self.items
            items.insert(items.remove(at: from.row), at: to.row)
            return ContentsTableViewModel(items: items)
        case .deleteItem(let forIndex):
            var items = self.items
            items.remove(at: forIndex.row)
            return ContentsTableViewModel(items: items)
        }
    }
}
