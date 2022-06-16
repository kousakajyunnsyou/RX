//
//  Combining_Obseravles.swift
//  fan_recoder.co
//
//  Created by yons on 2021/1/19.
//  Copyright © 2021 yons. All rights reserved.
//
/*  这是用来记录 结合操作符 的使用方式
    startWith, merge, zip
    相应的结果在控制台里体现
 */
import Foundation
import UIKit
import RxSwift
import RxCocoa

class Combining_Obseravles {

    let disposedBag = DisposeBag()
    
    //satrtWith
    //指定额外的元素作为开头；多个startWith 连续使用也是可以的
    /*** 结果
     1
     2
     3
     ***/
    public func rx_startWith() -> Void {
        Observable.from([2,3])
            .startWith("1")
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposedBag)
    }
    
    // merge
    //将两个及以上的 Observable 序列 合并成一个 Observable
    /**** 结果
     2
     6
     8
     9
     47
     ***/
    public func rx_merge() -> Void {
        
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposedBag)
        
        subject2.onNext(2)
        subject2.onNext(6)
        subject2.onNext(8)
        subject1.onNext(9)
        subject1.onNext(47)
    }
    
    //zip
    //将两个及其以上的事件整和作为一个事件发送出来
    /*** 结果
     32ox
     sd8
     ***/
    
    public func rx_zip() {
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        Observable.zip(subject1, subject2) {
            "\($0)\($1)"
        }.subscribe(onNext : {
            print($0)
        }).disposed(by: disposedBag)
        
        subject2.onNext("ox")
        subject2.onNext("8")
        subject1.onNext("32")
        subject1.onNext("sd")
    }
    

}
