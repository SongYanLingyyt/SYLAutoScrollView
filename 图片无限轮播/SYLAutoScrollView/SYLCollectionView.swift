//
//  SYLCollectionView.swift
//  图片无限轮播
//
//  Created by 岚海网络 on 15/12/29.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

protocol SYLCollectionViewDelegate {
    func shouldClickedScrollView(index: NSInteger)
}

class SYLCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var imageArray: [UIImage]!
    var index: NSInteger!
    var timer: NSTimer!
    var timerInterval: CGFloat!
    var collectionViewSize: CGSize!
    var page: SYLPageControll!
    var ylDelegate: SYLCollectionViewDelegate!
    
    //实例化一个collectionView
    class func collectionView(frame: CGRect, imageArr: [UIImage], timeInterval: CGFloat, view: UIView, delegate: SYLCollectionViewDelegate) -> SYLCollectionView {
        
        //实例化流水布局
        let flowlayout = SYLCollectionViewFlowLayout.createFlowlayoutWithClassName("SYLCollectionView")
        //实例化collectionView
        let collectionView = SYLCollectionView(frame: frame, collectionViewLayout: flowlayout)
        
        collectionView.backgroundColor = UIColor.grayColor()
        
        collectionView.imageArray = imageArr
        
        collectionView.timerInterval = timeInterval
        
        collectionView.ylDelegate = delegate
        
        collectionView.addTimer()
        
        //添加pageController
        let ylPage = SYLPageControll.createPage()
        
        //根据图片数获取怕个的宽高
        let pageSize = ylPage.sizeForNumberOfPages(collectionView.imageArray.count)
        
        ylPage.frame = CGRectMake(0, 0, pageSize.width, pageSize.height)
        
        ylPage.center = CGPointMake(collectionView.center.x, CGRectGetMaxY(collectionView.frame) - 20)
        
        collectionView.page = ylPage
        
        collectionView.collectionViewSize = frame.size
        
        view.addSubview(collectionView)
        
        view.addSubview(ylPage)
        
        return collectionView
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: layout)
        self.setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置界面
    func setUp() {
        
        //滚动条取消
        self.showsHorizontalScrollIndicator = false
        
        self.showsVerticalScrollIndicator = false
        
        //弹簧效果
        self.bounces = false
        //翻页效果
        self.pagingEnabled = true
        
        self.dataSource = self
        
        self.delegate = self
        
        //注册cell  自定义
        self.registerClass(SYLCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "SYLCollectionViewCell")
        self.index = 1000
        
        let indexPath = NSIndexPath(forItem: self.index, inSection: 0)
        
        //默认一开始滚动到第1000张图片的位置
        self.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        
    }
    
    func addTimer() {
        
        let yltimer = NSTimer.scheduledTimerWithTimeInterval(Double(self.timerInterval), target: self, selector: "scrollImage", userInfo: nil, repeats: true)
        
        //添加到运行循环
        NSRunLoop.currentRunLoop().addTimer(yltimer, forMode: NSDefaultRunLoopMode)
        
        self.timer = yltimer
    }
    
    func deleteTimer() {
        
        if self.timer != nil {
            
            self.timer.invalidate()
            
            self.timer = nil

        }
    }
    //计时器方法
    func scrollImage() {
        
        //让图片索引++
        self.index = self.index + 1
        
        let indexPath = NSIndexPath(forItem: self.index, inSection: 0)
        
        self.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        
        self.page.currentPage = self.index % self.imageArray.count
        
    }
    
     /*****collection view delegate*****/
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //因为图片需要无限滚动，所以返回一个无限大的数
        return 1000 * 1000
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SYLCollectionViewCell", forIndexPath: indexPath) as! SYLCollectionViewCell
       
        //取出图片赋值给cell
        cell.setImage(self.imageArray[indexPath.item % self.imageArray.count])
        
        cell.imageSize = self.collectionViewSize
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.ylDelegate.shouldClickedScrollView(indexPath.item % self.imageArray.count)
        
    }
    
    //手指滚动图片时
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        self.deleteTimer()
    }
    
    //滚动结束之后发出通知， 让控制器接收通知，设置page的当前页数
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let ylindex = scrollView.contentOffset.x / scrollView.bounds.width
        
        self.index = NSInteger(ylindex)
        
        self.page.currentPage = self.index % self.imageArray.count
        
        self.addTimer()
        
    }
}
