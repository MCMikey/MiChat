//
//  HomeViewController.swift
//  MiChat
//
//  Created by Mikey on 16/8/19.
//  Copyright © 2016年 mikey. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var tableView = UITableView()
    
    let identifier = "sdafsd"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView() {
        setNavTitle("MiMi")
    
        tableView.frame = CGRectMake(0, NavigationBarHeight, ScreenWidth, ScreenHeight - NavigationBarHeight - TabBarHeight)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.lightGrayColor()
        tableView.registerClass(ChatTableViewCell.self, forCellReuseIdentifier: identifier)
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ChatTableViewCell
        return cell!
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
}


