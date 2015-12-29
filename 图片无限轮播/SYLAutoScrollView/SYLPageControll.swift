//
//  SYLPageControll.swift
//  图片无限轮播
//
//  Created by 岚海网络 on 15/12/29.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

class SYLPageControll: UIPageControl {

    class func createPage() -> SYLPageControll {
        
        let page = SYLPageControll()
        
        page.currentPage = 0
        
        page.numberOfPages = 10
        
        page.currentPageIndicatorTintColor = UIColor.redColor()
        
        page.pageIndicatorTintColor = UIColor.cyanColor()
        
        return page
    }
    
    override init(frame: CGRect) {
        
      super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
