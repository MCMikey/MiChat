//
//  LoginViewController.swift
//  MiChat
//
//  Created by XFB on 16/8/19.
//  Copyright © 2016年 mikey. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {

    /// 用户名输入框
    let tfUserName = UITextField()
    
    /// 密码输入框
    let tfPassword = UITextField()
    
    /// 登录按钮
    let btnLogin = UIButton()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        
        tfUserName.placeholder = "用户名"
        tfUserName.font = UIFont.systemFontOfSize(14)
        tfUserName.backgroundColor = UIColor.lightGrayColor()
    
        tfPassword.placeholder = "密码"
        tfUserName.font = UIFont.systemFontOfSize(14)
        tfPassword.backgroundColor = UIColor.lightGrayColor()
        
        btnLogin.setTitle("登录", forState: .Normal)
        btnLogin.backgroundColor = ColorTool.themeColor()
        btnLogin.titleLabel?.font = UIFont.systemFontOfSize(15)
        btnLogin.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btnLogin.layer.masksToBounds = true
        btnLogin.layer.cornerRadius = 5
        btnLogin.addTarget(self, action: #selector(clickLogin(_:)), forControlEvents: .TouchUpInside)
        
        view.addSubview(tfUserName)
        view.addSubview(tfPassword)
        view.addSubview(btnLogin)
        
        // Snap布局
        tfUserName.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(64 + 40)
            make.height.equalTo(40)
        }
        tfPassword.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(tfUserName.snp_bottom).offset(10)
            make.height.equalTo(40)
        }
        btnLogin.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(tfPassword.snp_bottom).offset(25)
            make.height.equalTo(49)
        }
    }
    
    /// 登录事件
    func clickLogin(sender: UIButton) {
        
        MiSocketServe.sharedInstance.socketConnectHost("www.paypal.com", port: 443)
//        MiSocketServe.sharedInstance.socketConnectHost("google.com", port: 80)

        
        let tb = CustomTabBarViewController()
//        navigationController?.pushViewController(tb, animated: true)
        self.navigationController?.setViewControllers([tb], animated: true)
    }
}
