//
//  ViewController.swift
//  图片无限轮播
//
//  Created by 岚海网络 on 15/12/29.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SYLCollectionViewDelegate {

    //传递给cell的图片数组
    var images: [UIImage]!
    
    let imageCount = 10
    let imageHeight: CGFloat = 300
    
    func setImages() -> [UIImage] {
        
        if self.images == nil {
            
            self.images = []
            
            for var i = 1; i <= self.imageCount; i++ {
                
                let imageName = NSString(format: "%02d.jpg", i)
                
                let image = UIImage(named: imageName as String)
                
                self.images.append(image!)
            }
            
        }
        return self.images
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setImages()
        
        SYLCollectionView.collectionView(CGRectMake(0, 20, self.view.frame.width, self.imageHeight), imageArr: self.images, timeInterval: 1.5, view: self.view, delegate: self)
        
    }
    
    func shouldClickedScrollView(index: NSInteger) {
        print("我是第\(index + 1)张图")
    }
    
}

