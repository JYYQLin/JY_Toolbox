//
//  JY_WebView_Controller.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/25.
//

import UIKit
import WebKit

class JY_WebView_Controller: JY_Base_Controller {

    private lazy var yq_navigation_title: String = ""
    private lazy var yq_url_string: String = ""
    
    private lazy var yq_webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        return webView
    }()
    
    init(navigationTitle: String? = nil, urlString: String) {
        super.init(nibName: nil, bundle: nil)
        
        if navigationTitle != nil {
            yq_navigation_title = navigationTitle!
        }
        yq_url_string = urlString
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JY_WebView_Controller {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yq_load_url()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        guard let navigationController = self.navigationController as? JY_Navigation_Controller else {
            return
        }
        
        navigationController.yq_set_light_navigationBar()
    }
}

extension JY_WebView_Controller {
    private func yq_load_url() {
        guard let url = URL(string: yq_url_string)  else {
            return
        }
        
        yq_controller_status = .yq_loading
        var request = URLRequest(url: url)
        request.timeoutInterval = 15
        yq_webView.load(request)
    }
    
    override func yq_retry_request_click() {
        super.yq_retry_request_click()
        
        yq_load_url()
    }
}

extension JY_WebView_Controller {
    
    override func yq_setNavigationBar() {
        super.yq_setNavigationBar()
        
        title = yq_navigation_title
    }
    
    override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_content_view.addSubview(yq_webView)
    }
    
    override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        let Y = view.safeAreaInsets.top
        let bottom = view.safeAreaInsets.bottom
        
        yq_webView.frame = CGRect(x: 0, y: Y, width: yq_content_view.frame.width, height: yq_content_view.frame.height - Y)
        yq_webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
    }
}

extension JY_WebView_Controller: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        yq_controller_status = .yq_data_loaded
    }
}

extension JY_WebView_Controller {
    static func yq_show(_ fromController: UIViewController, navigationTitle: String? = nil, urlString: String) {
        
        let controller = JY_WebView_Controller(navigationTitle: navigationTitle, urlString: urlString)
        controller.hidesBottomBarWhenPushed = true
        
        if fromController.navigationController != nil {
            fromController.navigationController?.pushViewController(controller, animated: true)
        }
        else {
            fromController.present(JY_Navigation_Controller(rootViewController: controller), animated: true)
        }
    }
}

