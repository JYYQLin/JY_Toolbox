//
//  ViewController.swift
//  JY_ToolBox
//
//  Created by 林君扬 on 2025/4/19.
//

import UIKit

class ViewController: JY_Base_Controller {
    
    private lazy var yq_tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.yq_ID())
        
        return tableView
    }()
}

extension ViewController {
    override func yq_setNavigationBar() {
        super.yq_setNavigationBar()
        
        title = "JY_ToolBox"
    }
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(yq_tableView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        yq_tableView.frame = view.bounds
        yq_tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.yq_ID()) as? TableViewCell else {
            return TableViewCell(style: .default, reuseIdentifier: TableViewCell.yq_ID())
        }
        
        if indexPath.row == 0 {
            cell.yq_set(title: "扩展 - Extension")
        }
                        
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            JY_Extension_TableView_Controller.yq_show(self)
        }
    }
}
