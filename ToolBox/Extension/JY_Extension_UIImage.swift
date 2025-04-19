//
//  JY_Extension_UIImage.swift
//  JY_ToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

//  MARK: 生成纯色图片
extension UIImage {
    /** 生成纯色图片 */
    public static func yq_generate_image(color: UIColor, imageSize: CGSize, cornerRadius: CGFloat = 0, roundingCorners: UIRectCorner = .allCorners) -> UIImage? {
        
        let imageName = ("\(color)" + "_si_" + "\(imageSize.width) * \(imageSize.height)" + "co_" + "\(cornerRadius)" + "ro_" + "\(roundingCorners)").yq_md5()
        
        let localImage = JY_File_Manager.yq_readImage(fileName: imageName, directory: .caches)
        
        if localImage != nil {
            return localImage!
        }
        
        if imageSize.width == 0 || imageSize.height == 0 {
            return nil
        }
        
        UIGraphicsBeginImageContext(imageSize)
        // 获取绘图上下文
        
        guard let context = UIGraphicsGetCurrentContext() else {
            // 结束绘图
            UIGraphicsEndImageContext()
            return nil
        }
        
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: imageSize), byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        path.addClip()
        
        // 设置填充颜色
        context.setFillColor(color.cgColor)
        // 使用填充颜色填充区域
        context.fill(CGRect(origin: .zero, size: imageSize))
        
        // 获取绘制的图像
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            // 结束绘图
            context.restoreGState()
            UIGraphicsEndImageContext()
            return nil
        }
        
        // 结束绘图
        context.restoreGState()
        UIGraphicsEndImageContext()
                
        DispatchQueue(label: "JY_Extension_UIImage_SaveImage").async {
            
            JY_File_Manager.yq_saveImage(image: image, fileName: imageName, directory: .caches) { progress in
                print("图片保存进度 = \(progress)")
            } completion: { isSuccess in
                print("图片是否成功 = \(isSuccess)")
            }

        }
        
        return image
    }
}


//  MARK: 生成渐变色图片
extension UIImage {
    /**
     生成渐变色图片 */
    public static func yq_generate_image(colorArray: [UIColor], gradientType: JY_Enum_Gradient, imageSize: CGSize, cornerRadius: CGFloat = 0, roundingCorners: UIRectCorner = .allCorners) -> UIImage? {
        
        let imageName = ("\(colorArray)" + "_gr" + "\(gradientType)" + "_si_" + "\(imageSize.width) * \(imageSize.height)" + "co_" + "\(cornerRadius)" + "ro_" + "\(roundingCorners)").yq_md5()
        
        let localImage = JY_File_Manager.yq_readImage(fileName: imageName, directory: .caches)
        
        if localImage != nil {
            return localImage!
        }
        
        if imageSize.width == 0 || imageSize.height == 0 {
            return nil
        }
        
        if colorArray.count <= 0 {
            return nil
        }
        
        var cgColorArray = [CGColor]()
        for color in colorArray {
            cgColorArray.append(color.cgColor)
        }
        
        UIGraphicsBeginImageContext(imageSize)
        // 获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            // 结束绘图
            UIGraphicsEndImageContext()
            return nil
        }
        
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: imageSize), byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        path.addClip()
        
        let colorSpace = cgColorArray.last!.colorSpace
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColorArray as CFArray, locations: nil) else {
            // 结束绘图
            context.restoreGState()
            UIGraphicsEndImageContext()
            return nil
        }
        
        var startPoint: CGPoint = .zero
        var endPoint: CGPoint = .zero
        
        if gradientType == .topToBottom {
            startPoint = .zero
            endPoint = CGPoint(x: 0, y: imageSize.height)
        }else if gradientType == .leftToRight {
            startPoint = .zero
            endPoint = CGPoint(x: imageSize.width, y: 0)
        }else if gradientType == .upLeftToBottomRight {
            startPoint = .zero
            endPoint = CGPoint(x: imageSize.width, y: imageSize.height)
        }else if gradientType == .upRightToBottomLeft {
            startPoint = CGPoint(x: imageSize.width, y: 0)
            endPoint = CGPoint(x: 0, y: imageSize.height)
        }
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        
        // 获取绘制的图像
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            // 结束绘图
            context.restoreGState()
            UIGraphicsEndImageContext()
            return nil
        }
        
        // 结束绘图
        context.restoreGState()
        UIGraphicsEndImageContext()
        
        DispatchQueue(label: "JY_Extension_UIImage_SaveImage").async {
            
            JY_File_Manager.yq_saveImage(image: image, fileName: imageName, directory: .caches) { progress in
                print("图片保存进度 = \(progress)")
            } completion: { isSuccess in
                print("图片是否成功 = \(isSuccess)")
            }
            
        }
        
        return image
    }
}


public enum JY_Enum_Gradient {
    /** 从上到小 */
    case topToBottom
    /** 从左到右 */
    case leftToRight
    /** 左上到右下 */
    case upLeftToBottomRight
    /** 右上到左下 */
    case upRightToBottomLeft
}


import CoreImage

extension UIImage {
    /** 压缩图片到指定大小 */
    public func yq_compress_original_image(size: CGFloat) -> Data {
        let kb: CGFloat = size
        
        var compression: CGFloat = 0.9
        let maxCompression: CGFloat = 0.1
        guard var imageData = jpegData(compressionQuality: compression) else {
            return pngData() ?? Data()
        }
        while CGFloat(imageData.count) > (kb * 0.5) && compression > maxCompression {
            compression = compression - 0.1
            guard let tempData = jpegData(compressionQuality: compression) else {
                return pngData() ?? Data()
            }
            
            imageData = tempData
        }
        return imageData
    }
}
