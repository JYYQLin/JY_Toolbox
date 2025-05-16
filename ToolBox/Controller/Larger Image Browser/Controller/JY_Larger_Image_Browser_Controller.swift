//
//  JY_Larger_Image_Browser_Controller.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/4/28.
//

import UIKit

class JY_Larger_Image_Browser_Controller: JY_Base_Controller {
    
    private lazy var yq_current_index: Int = 0
    
    private lazy var yq_image_pageController: JY_Scroll_PageController = JY_Scroll_PageController()
    
    private lazy var yq_image_array: [UIImage] = [UIImage]()
    init(imageArray: [UIImage], index: Int = 0) {
        super.init(nibName: nil, bundle: nil)
        
        yq_image_array = imageArray
        yq_current_index = index
    }
    
    
    private lazy var yq_imageUrlString_array: [String] = [String]()
    init(imageStringArray: [String], index: Int = 0) {
        super.init(nibName: nil, bundle: nil)
        
        yq_current_index = index
        yq_imageUrlString_array = imageStringArray
    }
    
    private lazy var yq_imageUrl_array: [URL] = [URL]()
    init(imageUrlArray: [URL], index: Int = 0) {
        super.init(nibName: nil, bundle: nil)
        
        yq_current_index = index
        yq_imageUrl_array = imageUrlArray
    }
        
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension JY_Larger_Image_Browser_Controller {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageControllerArray = [JY_Larger_Image_Detail_Controller]()
        
        if yq_imageUrl_array.count > 0 {
            
            for imageUrl in yq_imageUrl_array {
                let imageController = JY_Larger_Image_Detail_Controller()
                imageController.yq_set(imageUrl: imageUrl)
                imageControllerArray.append(imageController)
            }
            
            yq_image_pageController.yq_set(controllerArray: imageControllerArray)
        }
        
        if yq_imageUrlString_array.count > 0 {
            for imageUrl in yq_imageUrlString_array {
                let imageController = JY_Larger_Image_Detail_Controller()
                imageController.yq_set(imageUrlString: imageUrl)
                imageControllerArray.append(imageController)
            }
            
            yq_image_pageController.yq_set(controllerArray: imageControllerArray)
        }
        
        if yq_image_array.count > 0 {
            for image in yq_image_array {
                let imageController = JY_Larger_Image_Detail_Controller()
                imageController.yq_set(image: image)
                imageControllerArray.append(imageController)
            }
            
            yq_image_pageController.yq_set(controllerArray: imageControllerArray)
        }
    }
}

extension JY_Larger_Image_Browser_Controller {
    override func yq_setInterface() {
        super.yq_setInterface()
        
        addChild(yq_image_pageController)
        yq_content_view.addSubview(yq_image_pageController.view)
    }
    
    override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_background_content_view.backgroundColor = UIColor.yq_color(colorString: "#010101")
        
        yq_image_pageController.view.frame = yq_content_view.bounds
    }
}

extension JY_Larger_Image_Browser_Controller {
    
    class func yq_show(_ fromController: UIViewController, imageArray: [UIImage], index: Int = 0) {
        let controller = JY_Larger_Image_Browser_Controller(imageArray: imageArray, index: index)
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        fromController.present(controller, animated: true)
    }
    
    class func yq_show(_ fromController: UIViewController, imageStringArray: [String], index: Int = 0) {
        let controller = JY_Larger_Image_Browser_Controller(imageStringArray: imageStringArray, index: index)
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        fromController.present(controller, animated: true)
    }
    
    class func yq_show(_ fromController: UIViewController, imageUrlArray: [URL], index: Int = 0) {
        let controller = JY_Larger_Image_Browser_Controller(imageUrlArray: imageUrlArray, index: index)
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        fromController.present(controller, animated: true)
    }
}
