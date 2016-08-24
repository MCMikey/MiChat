//
//  ChatInterfaceViewController.swift
//  MiChat
//
//  Created by XFB on 16/8/22.
//  Copyright © 2016年 mikey. All rights reserved.
//

import UIKit

class ChatInterfaceViewController: BaseViewController {

    var tableView = UITableView()
    let identifier = "homeCell"

    /// 聊天数组
    var dataSource = [ChatInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
//        initData()
    }
    
    func initData() {
        var info = ChatInfo()
        info.chaterName = "周杰伦"
        info.chatContent = "爱像一阵风，吹完它就走。"
        info.chatTime = "13:56"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "罗志祥"
        info.chatContent = "我想要自我催眠，痛苦会少一些。"
        info.chatTime = "13:53"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "爱因沙坦"
        info.chatContent = "撒地方啦啥打发啦"
        info.chatTime = "13:53"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "名侦探柯南"
        info.chatContent = "撒地方啦啥阿萨德发的是发的是打发啦"
        info.chatTime = "昨天"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "巴拉巴拉小魔仙"
        info.chatContent = "摸摸摸Mojo你你你摸摸摸"
        info.chatTime = "昨天"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "阿斯蒂芬"
        info.chatContent = "去问问企鹅全文"
        info.chatTime = "星期三"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "斯蒂芬周"
        info.chatContent = "权威偶偶一uoiwqwe"
        info.chatTime = "星期三"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "爱因沙坦"
        info.chatContent = "撒地方啦啥打发啦"
        info.chatTime = "星期三"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "爱因沙坦"
        info.chatContent = "撒地方啦啥打发啦"
        info.chatTime = "星期三"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "爱因沙坦"
        info.chatContent = "撒地方啦啥打发啦"
        info.chatTime = "星期二"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "爱因沙坦"
        info.chatContent = "撒地方啦啥打发啦"
        info.chatTime = "星期二"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "爱因沙坦"
        info.chatContent = "撒地方啦啥打发啦"
        info.chatTime = "星期二"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "爱因沙坦"
        info.chatContent = "撒地方啦啥打发啦"
        info.chatTime = "星期二"
        dataSource.append(info)
        
        info = ChatInfo()
        info.chaterName = "爱因沙坦"
        info.chatContent = "撒地方啦啥打发啦"
        info.chatTime = "星期二"
        dataSource.append(info)
        
        tableView.reloadData()
    }

    func initView() {
        setNavTitle(titleName, haveBackButton: true)
        tableView.frame = CGRectMake(0, NavigationBarHeight, ScreenWidth, ScreenHeight - NavigationBarHeight)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.lightGrayColor()
        tableView.registerClass(ChatTableViewCell.self, forCellReuseIdentifier: identifier)
        view.addSubview(tableView)
    }
}

extension ChatInterfaceViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ChatTableViewCell
        
        if cell == nil {
            cell = ChatTableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        let info = dataSource[indexPath.row]
        
        cell?.labelTitle?.text = info.chaterName
        cell?.labelDesc?.text = info.chatContent
        cell?.labelTime?.text = info.chatTime
        return cell!
    }
}

extension ChatInterfaceViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let info = dataSource[indexPath.row]
        let vc = ChatInterfaceViewController()
        vc.titleName = info.chaterName
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
