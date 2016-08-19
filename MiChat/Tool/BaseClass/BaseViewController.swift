//
//  BaseViewController.swift
//  MiChat
//
//  Created by XFB on 16/8/19.
//  Copyright © 2016年 mikey. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var titleLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        view.backgroundColor = ColorTool.ColorViewBG()
        automaticallyAdjustsScrollViewInsets = false
    }
    
    /// 导航栏title（系统）
    func setNavTitle(navTitle: String?) {
        if navTitle != nil && navTitle != "" {
            titleLabel = UILabel(frame: CGRectMake(0, 0, 100, 44))
            titleLabel!.textColor = UIColor.whiteColor()
            titleLabel!.font = UIFont.boldSystemFontOfSize(17)
            titleLabel!.textAlignment = .Center
            titleLabel!.text = navTitle
            navigationItem.titleView = titleLabel!
        }
    }
    
    /// 设置导航栏, 是否需要返回按钮 (系统)
    func setNavTitle(navTitle: String?, haveBackButton: Bool) {
        setNavTitle(navTitle)
        if haveBackButton {
            let btnBack = UIButton(type: .Custom)
            btnBack.frame = CGRectMake(0, 0, 44, 44)
            btnBack.backgroundColor = UIColor.redColor()
            btnBack.addTarget(self, action: #selector(clickBackVC), forControlEvents: .TouchUpInside)
            let backBarButton = UIBarButtonItem(customView: btnBack)
            let spaceBarButton = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
            spaceBarButton.width = -5
            navigationItem.leftBarButtonItems = [spaceBarButton, backBarButton]
        }
    }
    
    // 返回按钮点击事件
    func clickBackVC() {
        navigationController?.popViewControllerAnimated(true)
    }
}



