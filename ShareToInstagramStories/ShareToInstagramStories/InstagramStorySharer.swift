//
//  InstagramStoriesSharer.swift
//  ShareToInstagramStories
//
//  Created by Ernesto Fernandez Calles on 12/11/2018.
//  Copyright © 2018 Ernesto Fernandez Calles. All rights reserved.
//

import UIKit

// Scheme parameters
let instagramStoriesScheme = "instagram-stories://share"

// Story parameters
let backgroundImageParameter = "com.instagram.sharedSticker.backgroundImage"
let backgroundVideoParameter = "com.instagram.sharedSticker.backgroundVideo"
let stickerImageParameter = "com.instagram.sharedSticker.stickerImage"
let backgroundTopColorParameter = "com.instagram.sharedSticker.backgroundTopColor"
let backgroundBottomColorParameter = "com.instagram.sharedSticker.backgroundBottomColor"
let contentUrlParameter = "com.instagram.sharedSticker.contentURL"


// MARK: -  Share backgroundImage and Sticker
func shareToInstagramStories(backgroundImageName:String, stickerImageName:String, contentUrl:String?) -> NSError? {
    
    if let backgroundImage = UIImage.init(named: backgroundImageName), let stickerImage = UIImage.init(named: stickerImageName) {
        return shareToInstagramStories(backgroundImage: backgroundImage, stickerImage: stickerImage, contentUrl: contentUrl)
    
    } else {
        return parametersError()
    }
}

func shareToInstagramStories(backgroundImage:UIImage, stickerImage:UIImage, contentUrl:String?) -> NSError? {
    
    if let backgroundImageData = UIImage.pngData(backgroundImage)(), let stickerImageData = UIImage.pngData(stickerImage)() {
        return shareToInstagramStories(backgroundImageData: backgroundImageData, stickerImageData: stickerImageData, contentUrl: contentUrl)
    } else {
        return parametersError()
    }
}

func shareToInstagramStories(backgroundImageData:Data, stickerImageData:Data, contentUrl:String?) -> NSError? {
    
    return share(backgroundImageData: backgroundImageData, backgroundVideoData:nil, stickerImageData: stickerImageData, backgroundTopColor:nil, backgroundBottomColor:nil, contentUrl: contentUrl)
}

// MARK: -  Share backgroundVideo and Sticker
func shareToInstagramStories(backgroundVideoName:String, stickerImageName:String, contentUrl:String?) -> NSError? {
    
    if let path = Bundle.main.path(forResource: backgroundVideoName, ofType: "mp4"), let stickerImage = UIImage.init(named: stickerImageName), let stickerImageData = UIImage.pngData(stickerImage)() {
        
        do {
            let videoData = try Data(contentsOf: URL.init(fileURLWithPath: path))
            return shareToInstagramStories(backgroundVideo: videoData, stickerImage: stickerImageData, contentUrl: contentUrl)
            
        } catch {
            return parametersError()
        }
    } else {
        return parametersError()
    }
}

func shareToInstagramStories(backgroundVideo:Data, stickerImage:Data, contentUrl:String?) -> NSError? {
    
    return share(backgroundImageData: nil, backgroundVideoData: backgroundVideo, stickerImageData: stickerImage, backgroundTopColor:nil, backgroundBottomColor:nil, contentUrl: contentUrl)
}

// MARK: - Share background colors and sticker
func shareToInstagramStories(topColor:UIColor, bottomColor:UIColor, stickerImageName:String, contentUrl:String?) -> NSError? {
    
    if let stickerImage = UIImage.init(named: stickerImageName), let stickerImageData = UIImage.pngData(stickerImage)() {
        return shareToInstagramStories(topColorHexString: topColor.hex, bottomColorHexString: bottomColor.hex, stickerImage: stickerImageData, contentUrl: nil)
    } else {
        return parametersError()
    }
}

func shareToInstagramStories(topColorHexString:String, bottomColorHexString:String, stickerImage:Data, contentUrl:String?) -> NSError? {
    
    return share(backgroundImageData: nil, backgroundVideoData: nil, stickerImageData: stickerImage, backgroundTopColor: topColorHexString, backgroundBottomColor:bottomColorHexString, contentUrl: nil)
}


// MARK: - Sharer
private func share(backgroundImageData:Data?, backgroundVideoData:Data?, stickerImageData:Data?, backgroundTopColor:String?, backgroundBottomColor:String?, contentUrl:String?) -> NSError? {
    
    if let schemeUrl = URL.init(string: instagramStoriesScheme), UIApplication.shared.canOpenURL(schemeUrl) {
        
        var parametersDictionary = [String:Any]()
        
        if let parameter = backgroundImageData {
            parametersDictionary[backgroundImageParameter] = parameter
        }
        
        if let parameter = backgroundVideoData {
            parametersDictionary[backgroundVideoParameter] = parameter
        }
        
        if let parameter = stickerImageData {
            parametersDictionary[stickerImageParameter] = parameter
        }
        
        if let parameter = backgroundTopColor {
            parametersDictionary[backgroundTopColorParameter] = parameter
        }
        
        if let parameter = backgroundBottomColor {
            parametersDictionary[backgroundBottomColorParameter] = parameter
        }
        
        if let parameter = contentUrl {
            parametersDictionary[contentUrlParameter] = parameter
        }
        
        if !parametersDictionary.keys.isEmpty {
            let pasteboardItems = [parametersDictionary]
            let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate:NSDate.init(timeIntervalSinceNow: 60)]
            
            UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
            
            UIApplication.shared.open(schemeUrl, options: [:], completionHandler: nil)
            
        } else {
            return parametersError()
        }
        
        
        return nil
    } else {
        
        return configurationError()
    }
}

// MARK: - Errors
private func parametersError() -> NSError {
    return NSError.init(domain: "instagramStoriesSharer", code: 1, userInfo: nil)
}

private func configurationError() -> NSError {
    return NSError.init(domain: "instagramStoriesSharer", code: 2, userInfo: nil)
}

// MARK: - Tools
extension UIView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIColor {
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0, 0, 0, 0)
    }
    
    var hex: String {
        return String(format: "#%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255))
    }
}
