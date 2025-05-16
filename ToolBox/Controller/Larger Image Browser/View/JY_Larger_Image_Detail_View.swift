//
//  JY_Larger_Image_Detail_View.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/8.
//

import UIKit

class JY_Larger_Image_Detail_View: JY_View {

    private lazy var yq_image: UIImage? = nil
    
    private lazy var yq_scorllView: JY_ScrollView = JY_ScrollView()
    private lazy var yq_imageView: JY_ImageView = JY_ImageView()
}

extension JY_Larger_Image_Detail_View {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_scorllView)
        
        yq_scorllView.addSubview(yq_imageView)
    }
}

extension JY_Larger_Image_Detail_View {
    func yq_set(image: UIImage) {
        yq_image = image
        layoutSubviews()
    }
}

extension JY_Larger_Image_Detail_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_scorllView.frame = bounds
        
        yq_imageView.frame.origin = {
            yq_imageView.image = yq_image
            
            yq_imageView.isHidden = yq_image == nil
            
            if yq_image != nil {
                
                var imageSize = yq_image!.size
                
                if imageSize.width > bounds.width || imageSize.height > bounds.height {
                                        
                    
                    if imageSize.width > bounds.width {
                        
                        let newImageHeight = imageSize.height * bounds.width / imageSize.width
                        
                        imageSize = CGSize(width: bounds.width, height: newImageHeight)
                    }
                    
                    if imageSize.height > bounds.height {
                        
                        let newImageWidth = imageSize.width * bounds.height / imageSize.height
                        
                        imageSize = CGSize(width: newImageWidth, height: bounds.height)
                    }
                }
                            
                yq_imageView.frame.size = CGSize(width: imageSize.width, height: imageSize.height)
                
            }
            
            return CGPoint(x: (yq_scorllView.frame.width - yq_imageView.frame.width) * 0.5, y: (yq_scorllView.frame.height - yq_imageView.frame.height) * 0.5)
        }()
        
        yq_scorllView.contentSize = yq_imageView.bounds.size
    }
}
