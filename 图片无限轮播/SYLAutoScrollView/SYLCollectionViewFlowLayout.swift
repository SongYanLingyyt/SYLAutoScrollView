//
//  SYLCollectionViewFlowLayout.swift
//  图片无限轮播
//
//  Created by 岚海网络 on 15/12/29.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

class SYLCollectionViewFlowLayout: UICollectionViewFlowLayout {


    
    //实例化一个流水布局
    class func createFlowlayoutWithClassName(className: NSString) -> SYLCollectionViewFlowLayout {
        
        let flowlayout = SYLCollectionViewFlowLayout()
        
        let kItemHeight = 300
        
        let kWidth = UIScreen.mainScreen().bounds.width
        
        //设置共同属性， 如滚动方向... (根据实际情况设置)
        //横向滚动
        flowlayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        //竖向滚动
//        flowlayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        if className.isEqualToString("SYLCollectionView") {
            
            //设置item大小
            flowlayout.itemSize = CGSizeMake(kWidth, CGFloat(kItemHeight))
            //设置最小行和列间距
            flowlayout.minimumLineSpacing = 0
            flowlayout.minimumInteritemSpacing = 0
            //设置组内间距
            flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
            
        } else {
            
            //其他情况 自定义
            
        }
        return flowlayout
    }
    
}
