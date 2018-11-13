//
//  ViewController.swift
//  ShareToInstagramStories
//
//  Created by Ernesto Fernandez Calles on 12/11/2018.
//  Copyright © 2018 Ernesto Fernandez Calles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testView: UIView!
    
    func showError(error: NSError) {
        let alertView = UIAlertController.init(title: nil, message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func shareImageAndSticker(_ sender: Any) {
        
        if let error = shareToInstagramStories(backgroundImage: "backgroundTestImage", stickerImage: "stickerTestImage", contentUrl: nil) {
            showError(error: error)
        }
    }
    
    @IBAction func shareVideoAndSticker(_ sender: Any) {
        shareToInstagramStories(backgroundVideoName: "testVideo", backgroundVideoExtension: "mp4", stickerImage: "stickerTestImage", contentUrl: nil)
    }
    
    @IBAction func shareColorAndSticker(_ sender: Any) {
        shareToInstagramStories(topColor: UIColor.red, bottomColor: UIColor.green, stickerImageName:"stickerTestImage", contentUrl: nil)
    }
    
    @IBAction func shareImageAndView(_ sender: Any) {
        
        if let bg = UIImage(named: "backgroundTestImage") {
            shareToInstagramStories(backgroundImage:  bg, stickerImage: testView.asImage(), contentUrl: nil)
        }
    }
}

