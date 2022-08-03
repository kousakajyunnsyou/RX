//
//  RxtableViewController.swift
//  fan_recoder.co
//
//  Created by yons on 2021/2/4.
//  Copyright © 2021 yons. All rights reserved.
//  UITableView的使用3：刷新表格数据
//  UITableView的使用4：表格数据的搜索过滤

import UIKit
import Foundation
import RxSwift
import RxDataSources
import RxCocoa

class RxSwift32And33: UIViewController {
    
    //表格
    @IBOutlet weak var test_table: UITableView!
    //取消按钮
    var cancelButton : UIBarButtonItem!
    //刷新按钮
    var refreshButton : UIButton!
    //搜索框
    var searchBar : UISearchBar!
    
    let disposeBao = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
        
        //点击‘刷新’，生成随机的数据
        let randomData = refreshButton.rx.tap.asObservable()
            .startWith(())    //在开始时能够加载一次数据
            .flatMapLatest{_ in
                //点击取消时停止请求数据
                self.getData().takeUntil(self.cancelButton.rx.tap)
            }
            .flatMap(filterData)
            .share(replay: 1, scope: .whileConnected)

        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell:{ (dataSource, tv, index, element) -> UITableViewCell in
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
            cell.textLabel?.text = "\(index.row). \(element)"
            return cell
        })
        
        randomData
            .bind(to: test_table.rx.items(dataSource: dataSource))
        .disposed(by: disposeBao)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        test_table.setEditing(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: 视图定义
    
    fileprivate func initView() {
        //注册一个单元格
        self.test_table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //创建一个刷新按钮
        refreshButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        refreshButton.setTitle("刷新", for: UIControl.State.normal)
        refreshButton.addTarget(self, action: #selector(self.refreshTable), for: UIControl.Event.touchUpInside)
        //创建一个取消按钮
        cancelButton = UIBarButtonItem(title: "取消请求", style: .plain, target: self, action: nil)
        cancelButton.tintColor = .white
        //添加到导航栏上
        let refreshItem = UIBarButtonItem(customView: refreshButton)
        self.navigationItem.setRightBarButton(refreshItem, animated: false)
        self.navigationItem.setRightBarButtonItems([refreshItem,cancelButton], animated: false)
        
        //初始化搜索框
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 60))
        self.test_table.tableHeaderView = self.searchBar
    }
    
    //处理数据
    func dataSource() -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, Int>> {
        return RxTableViewSectionedAnimatedDataSource(
            animationConfiguration: AnimationConfiguration(
                insertAnimation: .top,
                reloadAnimation: .fade,
                deleteAnimation: .left),
            configureCell: { (dataSource, tv, index, element) -> UITableViewCell in
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
                cell.textLabel?.text = "\(index.row). \(element)"
                return cell
        },
            canEditRowAtIndexPath: { (_, _) -> Bool in
                return true
        },
            canMoveRowAtIndexPath: { (_, _) -> Bool in
                return true
        })
    }
    
    //创建随机数据
    private func getData() -> Observable<[SectionModel<String,Int>]> {
        DebugLog.D("")
        let items = (0 ..< 5).map {_ in
            Int(arc4random())
        }
        let observable = Observable.just([SectionModel(model: "", items: items)])
        return observable.delay(2, scheduler: MainScheduler.instance)
    }

    //过滤生成的数据
    private func filterData(data: [SectionModel<String, Int>]) -> Observable<[SectionModel<String, Int>]> {
        return self.searchBar.rx.text.orEmpty.flatMapLatest { (query) -> Observable<[SectionModel<String,Int>]> in
            DebugLog.D("当前的检索条件为：\(query)")
            if query.isEmpty{
                return Observable.just(data)
            }else{
                var newData: [SectionModel<String, Int>] = []
                for section in data {
                    newData.append(SectionModel(model: section.model,
                                                 items: section.items.filter{"\($0)".contains(query)}))
                }
                return Observable.just(newData)
            }
        }
    }


    
    
    //点击了‘刷新’
    @objc func refreshTable()  {
        print("666666")
        
    }
    

}
