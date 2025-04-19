//
//  JY_Extension_TableView_Controller.swift
//  JY_ToolBox
//
//  Created by 林君扬 on 2025/4/19.
//

import UIKit

class JY_Extension_TableView_Controller: JY_Base_Controller {
    private lazy var yq_tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.yq_ID())
        
        return tableView
    }()
}

extension JY_Extension_TableView_Controller {
    override func yq_setNavigationBar() {
        super.yq_setNavigationBar()
        
        title = "扩展 - Extension"
    }
    
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

extension JY_Extension_TableView_Controller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.yq_ID()) as? TableViewCell else {
            return TableViewCell(style: .default, reuseIdentifier: TableViewCell.yq_ID())
        }
        
        if indexPath.row == 0 {
            cell.yq_set(title: "Int")
        }
        
        return cell
    }
}

extension JY_Extension_TableView_Controller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            JY_Extension_Int_Controller.yq_show(self)
        }
    }
}

extension JY_Extension_TableView_Controller {
    static func yq_show(_ fromController: UIViewController) {
        let controller = JY_Extension_TableView_Controller()
        fromController.navigationController?.pushViewController(controller, animated: true)
    }
}
