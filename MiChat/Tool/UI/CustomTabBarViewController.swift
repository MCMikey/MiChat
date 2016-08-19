//
//  CustomTabBarViewController.swift
//  Swift_Tab
//
//  Created by 黄星 on 15/8/31.
//  Copyright (c) 2015年 qingfanqie. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController, QFQTabBarDelegate {

    /**
    *  输入对应的数字，以便跳转界面 数字1为身边，2为我的，3为更多
    */
    var iPage:NSInteger = 0
    
    var tabBarView = TabBarView()
    
    // 单例
    class func shareInstance()->CustomTabBarViewController{
        struct Singleton{
            static var predicate:dispatch_once_t = 0
            static var instance:CustomTabBarViewController? = nil
        }
        dispatch_once(&Singleton.predicate,{
            Singleton.instance=CustomTabBarViewController()
            }
        )
        return Singleton.instance!
    }
    
    override func viewWillAppear(animated: Bool) {

        self.initViewPage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initView()
    }
    
    /**
    *  初始化TabBar , 子控制器
    */
    func initView() {
        
        let infoVC = HomeViewController()
        let nav = BaseNavigationViewController(rootViewController: infoVC)
        self.addChildViewController(nav)
        
        let videoVC = BaseViewController()
        let nav1 = BaseNavigationViewController(rootViewController: videoVC)
        addChildViewController(nav1)
        
        let heroVC = BaseViewController()
        let nav2 = BaseNavigationViewController(rootViewController: heroVC)
        addChildViewController(nav2)
        
//        self.view.backgroundColor = UIColor.darkGrayColor()
//        self.tabBarView! = TabBarView(frame: CGRectMake(0, kPHONE_HEIGHT - 49, kPHONE_WIDTH, 49))
        self.tabBarView.frame = CGRectMake(0, kPHONE_HEIGHT - 49, kPHONE_WIDTH, 49)
        self.tabBarView.tabDelegate = self
        self.view.addSubview(self.tabBarView)
        
        self.tabBarView.addTabBarButtons()
        
        let dic:NSDictionary = ["key":"1"]
        
        NSNotificationCenter.defaultCenter().postNotificationName("QUERY_RED_POINT", object: dic)
    }
    
    func initViewPage() {
        self.selectedIndex = self.iPage
        self.tabBarView.selectedBtn(self.iPage)
    }
    
    /**
    *  监听tabbar按钮的改变
    *  @param from   原来选中的位置
    *  @param to     最新选中的位置
    */
    func tabBar(tabBar: TabBarView, to: NSInteger) {
        
        print("此时下标为\(to)")
        self.selectedIndex = to
        self.iPage = to
    }
    
    // 查询红点是否显示
    func initData() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
          
            // 数据请求
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // 改变样式
                
            })
        })
    }
    
    /**
    *  初始化一个子控制器
    *
    *  @param childVc           需要初始化的子控制器
    */
    func setupChildViewController(childVc:UIViewController) {
        self.addChildViewController(childVc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
