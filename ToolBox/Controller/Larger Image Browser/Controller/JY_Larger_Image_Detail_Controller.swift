//
//  JY_Larger_Image_Detail_Controller.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/8.
//

import UIKit

class JY_Larger_Image_Detail_Controller: JY_Base_Controller {

    private lazy var yq_image: UIImage? = nil
    private lazy var yq_image_url: URL? = nil
    private lazy var yq_imageURL_string: String? = nil
    
    private lazy var yq_image_detail_view: JY_Larger_Image_Detail_View = JY_Larger_Image_Detail_View()
}

extension JY_Larger_Image_Detail_Controller {
    func yq_set(image: UIImage) {
        yq_image = image
    }
    
    func yq_set(imageUrl: URL) {
        yq_image_url = imageUrl
                
        let localImage = JY_File_Manager.yq_readImage(fileName: "\(imageUrl)".yq_md5(), directory: .caches)
        
        if localImage == nil {
            let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                    JY_Tip_HUD.yq_show_danger(tip: "图片加载失败")
                    return
                }
                
                if localImage == nil {
                    // 将下载的数据转换为UIImage
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.yq_image_detail_view.yq_set(image: image)
                            
                            JY_File_Manager.yq_saveImage(image: image, fileName: "\(imageUrl)".yq_md5(), directory: .caches) { progress in
                                
                            } completion: { _ in
                                
                            }
                        }
                    }
                }
            }
            
            // 启动任务
            task.resume()
        }
        else{
            yq_image_detail_view.yq_set(image: localImage!)
        }
    }
    
    func yq_set(imageUrlString: String) {
        yq_imageURL_string = imageUrlString
        
        guard let imageUrl = URL(string: imageUrlString) else {
            return
        }
        
        let localImage = JY_File_Manager.yq_readImage(fileName: imageUrlString.yq_md5(), directory: .caches)
        
        if localImage == nil {
            let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                    JY_Tip_HUD.yq_show_danger(tip: "图片加载失败")
                    return
                }
                
                // 将下载的数据转换为UIImage
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.yq_image_detail_view.yq_set(image: image)
                        
                        JY_File_Manager.yq_saveImage(image: image, fileName: imageUrlString.yq_md5(), directory: .caches) { progress in
                            
                        } completion: { _ in
                            
                        }
                    }
                }
            }
            
            // 启动任务
            task.resume()
        }
        else {
            yq_image_detail_view.yq_set(image: localImage!)
        }
        
    }
}

extension JY_Larger_Image_Detail_Controller {
    
    override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_content_view.addSubview(yq_image_detail_view)
    }
    
    override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_background_content_view.backgroundColor = UIColor.yq_color(colorString: "#010101")
        yq_image_detail_view.frame = yq_content_view.bounds
    }
}
