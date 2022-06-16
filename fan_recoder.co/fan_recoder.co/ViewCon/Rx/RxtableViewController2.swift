//
//  RxtableViewController2.swift
//  fan_recoder.co
//
//  Created by yons on 2021/3/12.
//  Copyright © 2021 yons. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class RxtableViewController2: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshButton: UIBarButtonItem!  //刷新按钮
    var addButton: UIBarButtonItem!      //新增按钮
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.refreshButton = UIBarButtonItem.init()
        initView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:视图定义
    
    func initView() {
        
        addButton = UIBarButtonItem()
        addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "66dfa1bac84bd36f0ed8a29f38922e39"), style: .done, target: self, action: nil)
        refreshButton = UIBarButtonItem(title: "刷新", style: .plain, target: self, action: nil)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let tableModel: ContentsTableViewModel?
        //刷新
        let refreshCommand = refreshButton.rx.tap.asObservable()
            .startWith(())
            .flatMapLatest { _ in
                self.getData()}
            .map(TableEditingCommand.setItems)
        //新增
        let addCommand = addButton.rx.tap.asObservable()
            .flatMapLatest{self.getData()}
            .map(TableEditingCommand.setItems)
        //删除
        let delCommand = self.tableView.rx.itemDeselected.asObservable()
            .map(TableEditingCommand.deleteItem)
        //移动
        let moveCommand = self.tableView.rx.itemMoved
            .map(TableEditingCommand.moveItem)
        
        
    }
    
    //MARK: 获取数据
    //产生随机数据
    func getData() -> Observable<[String]> {
        let items = (0...4).map { _ in
            "\(arc4random())"
        }
        return Observable.just(items)
    }

}
extension RxtableViewController2 {
    //创建表格数据
    func dataSource() -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, String>> {
        return RxTableViewSectionedAnimatedDataSource(
            
            animationConfiguration: AnimationConfiguration(
                insertAnimation: .top,
                reloadAnimation: .fade,
                deleteAnimation: .left),
            configureCell: { (dataSource, tableView, index, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
                cell.textLabel?.text = "随机数\(index): \(element)"
                return cell
        }, //允许删除
            canEditRowAtIndexPath: { (_,_) in
                return true
        }, //允许移动
            canMoveRowAtIndexPath: { (_,_) in
                    return true
            }
        )}
}
