//
//  JY_File_Manager+Image_Save.swift
//  JY_ToolBox
//
//  Created by JYYQLin on 2025/4/14.
//

import UIKit

public enum JY_Sandbox_Directory {
    case documents
    case library
    case caches
    case temp
}

extension JY_File_Manager {
    /**
        保存图片到沙盒路径
     */
    public static func yq_saveImage(image: UIImage, fileName: String, directory: JY_Sandbox_Directory, progressHandler: @escaping (Double) -> Void, completion: @escaping (Bool) -> Void) {
        // 获取沙盒目录
        var targetDirectory: URL?
        switch directory {
        case .documents:
            targetDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        case .library:
            targetDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
        case .caches:
            targetDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        case .temp:
            targetDirectory = URL(fileURLWithPath: NSTemporaryDirectory())
        }

        guard let documentsDirectory = targetDirectory else {
            completion(false)
            return
        }
        
        // 创建文件的完整路径
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // 尝试获取 PNG 格式的原图数据，如果失败则获取 JPEG 格式的最高质量数据
        var data: Data?
        if let pngData = image.pngData() {
            data = pngData
        } else if let jpegData = image.jpegData(compressionQuality: 1.0) {
            data = jpegData
        }
        guard let imageData = data else {
            completion(false)
            return
        }
        
        do {
            guard let outputStream = OutputStream(url: fileURL, append: false) else {
                return
            }
            outputStream.open()
            defer {
                outputStream.close()
            }
            
            let chunkSize = 1024 * 10 // 10KB 每块
            let totalChunks = Int(ceil(Double(imageData.count) / Double(chunkSize)))
            
            for chunkIndex in 0..<totalChunks {
                let startIndex = chunkIndex * chunkSize
                let endIndex = min(startIndex + chunkSize, imageData.count)
                let chunk = imageData[startIndex..<endIndex]
                let chunkData = Data(chunk)
                var bytesWritten = 0
                chunkData.withUnsafeBytes { buffer in
                    if let baseAddress = buffer.baseAddress {
                        bytesWritten = outputStream.write(baseAddress.assumingMemoryBound(to: UInt8.self), maxLength: chunkData.count)
                    }
                }
                if bytesWritten < 0 {
                    completion(false)
                    return
                }
                let progress = Double(chunkIndex + 1) / Double(totalChunks)
                progressHandler(progress)
            }
            completion(true)
        } catch {
            print("保存图片时出错: \(error)")
            completion(false)
        }
    }
}

extension JY_File_Manager {
    /**
       从沙盒路径取出图片
     */
    public static func yq_readImage(fileName: String, directory: JY_Sandbox_Directory) -> UIImage? {
        // 获取沙盒目录
      
        var targetDirectory: URL?
        switch directory {
        case .documents:
            targetDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        case .library:
            targetDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
        case .caches:
            targetDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        case .temp:
            targetDirectory = URL(fileURLWithPath: NSTemporaryDirectory())
        }

        guard let documentsDirectory = targetDirectory else {
            return nil
        }
        
        // 创建文件的完整路径
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            // 读取文件数据
            let imageData = try Data(contentsOf: fileURL)
            // 将数据转换为 UIImage
            return UIImage(data: imageData)
        } catch {
            print("读取图片时出错: \(error)")
            return nil
        }
    }
}
