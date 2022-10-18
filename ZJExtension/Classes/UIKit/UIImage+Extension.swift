//
//  UIImage+Extension.swift
//  Pods-ZJExtension_Example
//
//  Created by Jercan on 2022/10/18.
//

import UIKit

public extension UIImage {
    
    var round: UIImage? {
        
        UIGraphicsBeginImageContext(size)
        
        defer { UIGraphicsEndImageContext() }
        
        let ctx = UIGraphicsGetCurrentContext()
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        ctx?.addEllipse(in: rect)
        
        ctx?.clip()
        
        draw(in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
        
    }
    
}

public extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = .init(width: 1, height: 1)) {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.scaleBy(x: 1.0, y: -1.0)
        
        context.translateBy(x: 0.0, y: -size.height)
        
        context.setBlendMode(.multiply)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        color.setFill()
        
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        
        guard let aCgImage = image?.cgImage else { return nil }
        
        self.init(cgImage: aCgImage)
        
    }
    
}

public extension UIImage {
    
    convenience init?(name: String, bundle: Bundle) {
        
        let bundleName = bundle.infoDictionary?[kCFBundleNameKey as String] as? String
        
        if let resourceBundle = bundle.path(forResource: bundleName, ofType: "bundle").flatMap(Bundle.init) {
            self.init(named: name, in: resourceBundle, compatibleWith: nil)
        } else {
            self.init(named: name, in: bundle, compatibleWith: nil)
        }
        
    }
    
}

public extension UIImage {
    
    func compressedImage() -> UIImage {
        if let data = compressedData(), let image = UIImage(data: data) {
            return image
        }
        return self
    }
    
    func compressedData() -> Data? {
        
        if let imgData = jpegData(compressionQuality: 1) {
            
            let imgFileSize = imgData.count
            
            debugPrint("origin file size: \(imgFileSize)")
            
            if let info = CompressInfo(originalSize: size),
                let data = scaleTo(size: info.size).compressQualityToDataWith(maxLength: info.length) {
                
                 debugPrint("compressed file size: \(data.count)")
                
                 return data
                
            }
            
        }
        
        return nil
        
    }
    
    func compressQualityToDataWith(maxLength: CGFloat) -> Data? {
        
        var compression: CGFloat = 1.0
        
        guard var data = jpegData(compressionQuality: compression) else {
            return nil
        }
        
        while CGFloat(data.count) > maxLength, compression > 0.1 {
            
            compression -= 0.1
            
            if let temp = jpegData(compressionQuality: compression) {
                data = temp
            } else {
                return data
            }
            
        }
        
        return data
        
    }
    
    func scaleTo(size toSize: CGSize) -> UIImage {
                
        let factor: CGFloat = 1
        
        let dstSize = CGSize(width: size.width * factor, height: size.height * factor)
        
        UIGraphicsBeginImageContext(dstSize)
        
        defer { UIGraphicsEndImageContext() }
        
        draw(in: .init(origin: .zero, size: dstSize))
                        
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
        
    }
    
}

private struct CompressInfo {
    
    let size: CGSize
    
    let length: CGFloat
    
    init?(originalSize: CGSize) {
        
        let minValue = min(originalSize.width, originalSize.height)
        
        let maxValue = max(originalSize.width, originalSize.height)
        
        let ratio = minValue / maxValue
        
        if ratio > 0 && ratio <= 0.5 { // [1:1 ~ 9:16)
            
            switch maxValue {
            case 0..<1664:
                
                size = .init(width: minValue, height: maxValue)
                
                length = max(60, minValue * maxValue / pow(1664, 2) * 150)
                
            case 1664..<4990:
                
                size = .init(width: minValue / 2, height: maxValue / 2)
                
                let v = ((minValue / 2) * (maxValue / 2)) / pow(4990 / 2, 2)
                
                length = max(60,v * 300)
                
            case 4990..<10240:
                
                size = .init(width: minValue / 4, height: maxValue / 4)
                
                let v = ((minValue / 4) * (maxValue / 4)) / pow(10240 / 4, 2)
                
                length = max(100,v * 300)
                
            default:
                                
                let multiple = ((maxValue / 1280) == 0) ? 1 : (maxValue / 1280)
                
                size = .init(width: minValue / multiple, height: maxValue / multiple)
                
                length = max(100, ((minValue / multiple) * (maxValue / multiple)) / pow(2560, 2) * 300)
                
            }
            
        } else if ratio > 0.5 && ratio < 0.5625 { // [9:16 ~ 1:2)
                        
            let multiple = CGFloat(ceilf(Float(maxValue / (1280 / ratio))))
            
            length = max(100, ((minValue / multiple) * (maxValue / multiple)) / (1280 * (1280 / ratio)) * 500)
            
            size = .init(width: minValue / multiple, height: maxValue / multiple)
            
        } else if ratio >= 0.5625 && ratio <= 1 { // [1:2 ~ 1:∞)
            
            let multiple = ((maxValue / 1280) == 0) ? 1 : (maxValue / 1280)
            
            size = .init(width: minValue / multiple, height: maxValue / multiple)
            
            length = max(100, ((minValue / multiple) * (maxValue / multiple)) / (1440 * 2560) * 400)
            
        } else {
            return nil
        }
        
    }
    
}


