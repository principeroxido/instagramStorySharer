//
//  ViewController.swift
//  ShareToInstagramStories
//
//  Created by Ernesto Fernandez Calles on 12/11/2018.
//  Copyright © 2018 Ernesto Fernandez Calles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func shareImageAndSticker(_ sender: Any) {
        shareToInstagramStories(backgroundImageName: "backgroundTestImage", stickerImageName: "stickerTestImage", contentUrl: nil)
    }
    
    @IBAction func shareVideoAndSticker(_ sender: Any) {
        shareToInstagramStories(backgroundVideoName: "testVideo", stickerImageName: "stickerTestImage", contentUrl: nil)
    }
    
    @IBAction func shareColorAndSticker(_ sender: Any) {
        shareToInstagramStories(topColor: UIColor.red, bottomColor: UIColor.green, stickerImageName:"stickerTestImage", contentUrl: nil)
    }
}

