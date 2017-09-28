//
//  TabBarView.swift
//  Swift_Tab
//
//  Created by 黄星 on 15/8/31.
//  Copyright (c) 2015年 qingfanqie. All rights reserved.
//

import UIKit

let kPHONE_WIDTH = (UIScreen.mainScreen().bounds.size.width)
let kPHONE_HEIGHT = (UIScreen.mainScreen().bounds.size.height)
let kBUTTONCOUNT = 4

protocol QFQTabBarDelegate:NSObjectProtocol {
    func tabBar(tabBar:TabBarView, to:NSInteger)
}

class TabBarView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var tabDelegate:QFQTabBarDelegate?
    
    var str_img_nav = NSArray()
    var str_img_nav_focus = NSArray()
    var str_title = NSArray()
    var img_nav = NSMutableArray()
    var dic = NSMutableDictionary()
    
    // 按钮底图
    var imgTab_Nor = UIImage(named: "tab_nor")
    var imgTab_Sel = UIImage(named: "tab_sel")

    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.redColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TabBarView.hideView), name: "COMMON_TABBAR_MY", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TabBarView.showRedDot(_:)), name: "QUERY_RED_POINT", object: nil)
        
        self.str_img_nav = ["tab_btn_nor0", "tab_btn_nor6", "tab_btn_nor3", "tab_btn_nor4"]
        self.str_img_nav_focus = ["tab_btn_sel0", "tab_btn_sel6", "tab_btn_sel3", "tab_btn_sel4"]
        self.str_title = ["MiMi", "联系人", "发现", "我"];
    }
    
    func goFor(sender:UIButton) {
        for i in 0..<kBUTTONCOUNT {
            let button = self.img_nav[i] as! QFQTabBarButton
            self.setBtnNormal(button, index: i)
            if sender.tag == i {
                self.setBtnSelect(button, index: i)
            }
        }
        
        if self.tabDelegate != nil && self.tabDelegate?.respondsToSelector(Selector("tabBar:")) == false {
            self.tabDelegate?.tabBar(self, to: sender.tag)
        }
    }
    
    func selectedBtn(iPage:NSInteger) {
        for i in 0..<kBUTTONCOUNT {
            let button = self.img_nav[i] as! QFQTabBarButton
            self.setBtnNormal(button, index: i)
            if iPage == i {
                self.setBtnSelect(button, index: i)
            }
        }
    }
    
    /**
    *   加入内部按钮
    */
    func addTabBarButtons() {
        self.initView()
    }
    
    /**
        设置按钮普通状态
    */
    func setBtnNormal(sender:UIButton, index:NSInteger) {
        sender.setImage(UIImage(named: self.str_img_nav[index] as! String), forState: UIControlState.Normal)
        sender.setBackgroundImage(imgTab_Nor, forState: UIControlState.Normal)
    }
    
    /**
        设置按钮选中状态
    */
    func setBtnSelect(sender:UIButton, index:NSInteger) {
        sender.setImage(UIImage(named: self.str_img_nav_focus[index] as! String), forState: UIControlState.Normal)
        sender.setBackgroundImage(imgTab_Sel, forState: UIControlState.Normal)
    }
    
    // 退出登录时
    func hideView() {
        let button = self.img_nav[2] as! QFQTabBarButton
        button .hiddenView()
    }
    
    func showRedDot(data:NSNotification) {
        let dic:NSDictionary = data.object as! NSDictionary
        if dic["key"]?.isEqualToString("1") == true {
            // 让红点显示
            let button = self.img_nav[2] as! QFQTabBarButton
            button.hiddenView()
        } else {
            // 让红点消失
            let button = self.img_nav[2] as! QFQTabBarButton
            button.hideView()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        let tabBarBG = UIImageView(frame: CGRectMake(0, 0, kPHONE_WIDTH, 49))
        tabBarBG.userInteractionEnabled = true;
        tabBarBG.image = UIImage(named: "nav_bg")
        self.addSubview(tabBarBG)
        // 按钮的frame数据
        let buttonH = self.frame.size.height
        let buttonW = self.frame.size.width / CGFloat(kBUTTONCOUNT)
        let buttonY = 0
        
        for index in 0..<kBUTTONCOUNT {
            print("\(index)")
            let buttonX = CGFloat(index) * buttonW
            let item =  QFQTabBarButton(frame: CGRectMake(buttonX, CGFloat(buttonY), buttonW, buttonH))
            item.contentMode = UIViewContentMode.Center
            item.tag = index
            item.backgroundColor = UIColor.darkGrayColor()
            item.titleLabel?.font = UIFont.systemFontOfSize(13)
            item.setTitle(self.str_title[index] as? String, forState: UIControlState.Normal)
            self.setBtnNormal(item, index: index)
            item.addTarget(self, action: #selector(goFor(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.img_nav.addObject(item)
            self.addSubview(item)
        }
    }

}
