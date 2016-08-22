//
//  ChatInterfaceViewController.swift
//  MiChat
//
//  Created by XFB on 16/8/22.
//  Copyright © 2016年 mikey. All rights reserved.
//

import UIKit

class ChatInterfaceViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        setNavTitle(titleName, haveBackButton: true)
    }
}
