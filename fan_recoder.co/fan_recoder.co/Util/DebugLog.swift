//
//  DebugLog.swift
//  fan_recoder.co
//
//  Created by yons on 2021/3/12.
//  Copyright © 2021 yons. All rights reserved.
//

import Foundation

struct DebugLog {
    
    static let needLine:String = "--------------------------"
    
    static func T(_ message: String,_ args: CVarArg...,filename: String = #file,method: String = #function,line: Int = #line) {
        
        NSLog("%@ %d:%@\n\(needLine)\n%@\n\(needLine)",filename,line,method,String(format: message, args))
    }
    
    static func D(_ message: String,_ args: CVarArg...,filename: String = #file,method: String = #function,line: Int = #line) {
        
        NSLog("%@ %d:%@\n%@",filename,line,method,String(format: message, args))
    }
}
