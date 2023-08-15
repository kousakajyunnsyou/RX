//
//  URL+.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/8/10.
//  Copyright © 2022 yons. All rights reserved.
//
import UIKit

extension URL {
    //逆向获得url的参数
    var urlParameters: [String:String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
                  return nil
              }
        return queryItems.reduce(into: [String:String]()) { result, item in
            result[item.name] = item.value
        }
    }
}
