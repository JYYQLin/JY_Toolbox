//
//  JY_Extension_Int_Controller.swift
//  JY_ToolBox
//
//  Created by 林君扬 on 2025/4/19.
//

import UIKit

class JY_Extension_Int_Controller: JY_Base_Controller {
    
    private lazy var yq_scrollView: JY_ScrollView = {
        let scrollView = JY_ScrollView()
        
        return scrollView
    }()
    
    private lazy var yq_view_1: JY_Extension_Int_Example_View = JY_Extension_Int_Example_View()
}

extension JY_Extension_Int_Controller {
    override func yq_setNavigationBar() {
        super.yq_setNavigationBar()
        
    }
    
    override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_content_view.addSubview(yq_scrollView)
    }
}

extension JY_Extension_Int_Controller {
    
}

extension JY_Extension_Int_Controller {
    
}

extension JY_Extension_Int_Controller {
    static func yq_show(_ fromController: UIViewController) {
        let controller = JY_Extension_Int_Controller()
        fromController.navigationController?.pushViewController(controller, animated: true)
    }
}
