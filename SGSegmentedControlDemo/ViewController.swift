//
//  ViewController.swift
//  SGSegmentedControlDemo
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 YJS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, SGSegmentedControlDelegate {

    var mainScrollView : UIScrollView!
    var SG = SGSegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        setupChildViewController()
        setupSegmentedControl()
        self.title = "King"
        // Do any additional setup after loading the view.
    }
    
    func setupSegmentedControl() {
        let title_arr = ["精选", "电视剧", "电影", "综艺", "段子", "视屏", "养生"]
        mainScrollView = UIScrollView.init()
        mainScrollView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        mainScrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width * CGFloat(title_arr.count), 0)
        mainScrollView.backgroundColor = UIColor.clearColor()
        mainScrollView.pagingEnabled = true
        mainScrollView.bounces = false
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.delegate = self
        self.view.addSubview(mainScrollView)
        
        SG = SGSegmentedControl.init(frame: CGRectMake(0, 64, self.view.frame.size.width, 44)).initWithFrame(CGRectMake(0, 64, self.view.frame.size.width, 44), delegate: self, segmentedControlType: .SGSegmentedControlTypeScroll, titleArr: title_arr)
        SG.titleColorStateSelected = UIColor.purpleColor()
        SG.indicatorColor = UIColor.purpleColor()
        SG.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(SG)
    }
    
    func setupChildViewController() {
        let oneVc = OneViewController.init()
        self.addChildViewController(oneVc)
        
        let twoVc = TwoViewController.init()
        self.addChildViewController(twoVc)
        
        let threeVc = ThreeViewController.init()
        self.addChildViewController(threeVc)
        
        let fourVc = FourViewController.init()
        self.addChildViewController(fourVc)
        
        let fiveVc = FiveViewController.init()
        self.addChildViewController(fiveVc)
        
        let sixVc = SixViewController.init()
        self.addChildViewController(sixVc)
        
        let seventVc = SevenViewController.init()
        self.addChildViewController(seventVc)
    }
    
    func SGSegmentControl(segmentControl: SGSegmentedControl, didSelectBtnAtIndex index: NSInteger) {
        // 1 计算滚动的位置
        let offsetX = CGFloat(index) * self.view.frame.size.width
        self.mainScrollView.contentOffset = CGPointMake(offsetX, 0)
        
        // 2.给对应位置添加对应子控制器
        showVc(index)
    }
    
    // 显示控制器的view
    func showVc(index : NSInteger) {
        let offsetX = CGFloat(index) * self.view.frame.size.width
        
        let vc = self.childViewControllers[index]
        
        if vc.isViewLoaded() {
            return
        }
        vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.mainScrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = NSInteger(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        showVc(index)
        
        self.SG.titleBtnSelectedWithScrollView(scrollView)
    }


}

