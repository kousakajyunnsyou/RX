//
//  RxSwift30.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/8/2.
//  Copyright © 2022 yons. All rights reserved.
//  UITableView的使用1：基本用法

import UIKit
import RxCocoa
import RxSwift

class RxSwift30: UIViewController {

    
   var tableView:UITableView!
    
   let disposeBag = DisposeBag()
    
   override func viewDidLoad() {
       super.viewDidLoad()
        
       //创建表格视图
       self.tableView = UITableView(frame: self.view.frame, style:.plain)
       tableView.isEditing = true
       //创建一个重用的单元格
       self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
       self.view.addSubview(self.tableView!)
        
       //初始化数据
       let items = Observable.just([
           "文本输入框的用法",
           "开关按钮的用法",
           "进度条的用法",
           "文本标签的用法",
           ])
        
       //设置单元格数据（其实就是对 cellForRowAt 的封装）
       items
           .bind(to: tableView.rx.items) { (tableView, row, element) in
               let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
               cell.textLabel?.text = "\(row)：\(element)"
               return cell
           }
           .disposed(by: disposeBag)
       
       tableView.rx.itemSelected.subscribe(onNext: { indexPath in
           print("选中项的indexPath为：\(indexPath)")
       }).disposed(by: disposeBag)
       
       tableView.rx.itemDeselected.subscribe(onNext: { indexPath in
           print("被取消选中项的indexPath为：\(indexPath)")
       }).disposed(by: disposeBag)
       
       tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
           print("删除项的indexPath为：\(indexPath)")
       }).disposed(by: disposeBag)
       
       tableView.rx.itemMoved.subscribe(onNext: {
           print("移动项原来的indexPath为：\($0)")
           print("移动项现在的indexPath为：\($1)")
       }).disposed(by: disposeBag)
   }
}

//MARK: 单元格选中事件响应
/*
 1.如果业务代码直接放在响应方法内部，可以这么写：
 
 tableView.rx.itemSelected.subscribe(onNext: { indexPath in
     print("选中项的indexPath为：\(indexPath)")
 }).disposed(by: disposeBag)
  
 //获取选中项的内容
 tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
     print("选中项的标题为：\(item)")
 }).disposed(by: disposeBag)
 
 2.或者也可以在响应中调用外部的方法：
 
 //获取选中项的索引
 tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
     self?.showMessage("选中项的indexPath为：\(indexPath)")
 }).disposed(by: disposeBag)
  
 //获取选中项的内容
 tableView.rx.modelSelected(String.self).subscribe(onNext: {[weak self] item in
     self?.showMessage("选中项的标题为：\(item)")
 }).disposed(by: disposeBag)
*/


//MARK: 单元格取消选中事件响应
/*
 //获取被取消选中项的索引
 tableView.rx.itemDeselected.subscribe(onNext: { [weak self] indexPath in
     self?.showMessage("被取消选中项的indexPath为：\(indexPath)")
 }).disposed(by: disposeBag)
  
 //获取被取消选中项的内容
 tableView.rx.modelDeselected(String.self).subscribe(onNext: {[weak self] item in
     self?.showMessage("被取消选中项的的标题为：\(item)")
 }).disposed(by: disposeBag)
 */

//MARK: 单元格删除事件响应
/*
 //获取删除项的索引
 tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
     self?.showMessage("删除项的indexPath为：\(indexPath)")
 }).disposed(by: disposeBag)
  
 //获取删除项的内容
 tableView.rx.modelDeleted(String.self).subscribe(onNext: {[weak self] item in
     self?.showMessage("删除项的的标题为：\(item)")
 }).disposed(by: disposeBag)
 */

//MARK: 单元格移动事件响应
/*
 //获取移动项的索引
 tableView.rx.itemMoved.subscribe(onNext: { [weak self]
     sourceIndexPath, destinationIndexPath in
     self?.showMessage("移动项原来的indexPath为：\(sourceIndexPath)")
     self?.showMessage("移动项现在的indexPath为：\(destinationIndexPath)")
 }).disposed(by: disposeBag)
 */

//MARK: 单元格插入事件响应
/*
 //获取插入项的索引
 tableView.rx.itemInserted.subscribe(onNext: { [weak self] indexPath in
     self?.showMessage("插入项的indexPath为：\(indexPath)")
 }).disposed(by: disposeBag)
 */

//MARK: 单元格尾部附件（图标）点击事件响应
/*
 //获取点击的尾部图标的索引
 tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { [weak self] indexPath in
     self?.showMessage("尾部项的indexPath为：\(indexPath)")
 }).disposed(by: disposeBag)
 */

//MARK: 单元格将要显示出来的事件响应
/*
 //获取选中项的索引
 tableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
     print("将要显示单元格indexPath为：\(indexPath)")
     print("将要显示单元格cell为：\(cell)\n")
      
 }).disposed(by: disposeBag)
 */
