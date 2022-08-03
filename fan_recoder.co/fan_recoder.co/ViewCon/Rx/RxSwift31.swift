//
//  RxSwift31.swift
//  fan_recoder.co
//
//  Created by dousei hann on 2022/8/2.
//  Copyright © 2022 yons. All rights reserved.
//  UITableView的使用2：RxDataSources

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxSwift31: UIViewController {

    let disposeBag = DisposeBag()
    
    var tablebiew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建一个表格
        tablebiew = UITableView(frame: self.view.frame, style: .plain)
        //注册一个可重用的单元格
        tablebiew.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tablebiew)
        
        let items = Observable.just([
            SectionModel(model: "基础控件", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
            ]),
            SectionModel(model: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
                ])
        ])
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,String>> { dataSource, tablebiew, indexPath, element in
            let cell = tablebiew.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(indexPath.row): \(element)"
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        
        items.bind(to: tablebiew.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

//MARK: 如果使用使用自定义的Section
/*
class ViewController: UIViewController {
     
    var tableView:UITableView!
     
    let disposeBag = DisposeBag()
     
    override func viewDidLoad() {
        super.viewDidLoad()
         
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
         
        //初始化数据
        let sections = Observable.just([
            MySection(header: "基本控件", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ]),
            MySection(header: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
                ])
            ])
         
        //创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            //设置单元格
            configureCell: { ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "\(ip.row)：\(item)"
                 
                return cell
            },
            //设置分区头标题
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
            }
        )
         
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
 
//自定义Section
struct MySection {
    var header: String
    var items: [Item]
}
 
extension MySection : AnimatableSectionModelType {
    typealias Item = String
     
    var identity: String {
        return header
    }
     
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
 */
