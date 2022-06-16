//
//  DeleteClass.swift
//  fan_recoder.co
//
//  Created by yons on 2021/1/25.
//  Copyright © 2021 yons. All rights reserved.
//

import UIKit
import Foundation

class DeleteClass {
    
    static let name:String = "希儿"
    
    static func test() -> Void {
        (1...4).forEach {print("Happy Birthday" + (($0 == 3) ? "dear \(self.name) " : " to you"))}
    }
}
