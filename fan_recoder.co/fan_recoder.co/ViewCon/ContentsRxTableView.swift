//
//  ContentsRxTableView.swift
//  fan_recoder.co
//
//  Created by yons on 2021/1/27.
//  Copyright © 2021 yons. All rights reserved.
//  App功能的目录索引

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class ContentsRxTableView: UIViewController {

    @IBOutlet weak var contentsTable: UITableView!
    let disposeage = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        //单元格间隔样式
        contentsTable.separatorStyle = .singleLine
        //创建一个重用的单元格
        self.contentsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        //装入数据
        let items = Observable.just([
            ContentsTableSection(header: "", items: LcocatizedData.meun)
        ], scheduler: MainScheduler.instance)
        
        //创建数据源格式
        let dataSource = RxTableViewSectionedReloadDataSource<ContentsTableSection>(configureCell: { (dataSouce, tableview, index, element) -> UITableViewCell in
            let f_cell = tableview.dequeueReusableCell(withIdentifier: "cell")
            f_cell?.textLabel?.text = "\(index.row): \(element.name)"
            return f_cell ?? UITableViewCell.init()
        })
        
        //绑定单元格数据
        items
            .bind(to: contentsTable.rx.items(dataSource: dataSource))
            .disposed(by: disposeage)
        //点击事件
        contentsTable.rx
            .itemSelected
            .map { index in
                return (index, dataSource[index])
        }.subscribe(onNext: {(index,element) in
            print("点击了\(element)")
            if let storyboardName = element.toView {
                let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardName)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if let vc = element.vc {
                vc.view.backgroundColor = .white
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
 
}
