//
//  ChatTableViewCell.swift
//  MiChat
//
//  Created by Mikey on 16/8/19.
//  Copyright © 2016年 mikey. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    /// 头像
    var imgView: UIImageView?
    
    /// 标题
    var labelTitle: UILabel?
    
    /// 描述
    var labelDesc: UILabel?
    
    /// 时间
    var labelTime: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCell()
    }
    
    func initCell() {
        imgView = UIImageView()
        labelTitle = UILabel()
        labelDesc = UILabel()
        labelTime = UILabel()
        
        imgView?.layer.masksToBounds = true
        imgView?.layer.cornerRadius = 5
        imgView?.backgroundColor = ColorTool.themeColor()
        
        labelTitle?.textColor = UIColor.blackColor()
        labelTitle?.font = UIFont.boldSystemFontOfSize(14)
        
        labelDesc?.textColor = UIColor.darkGrayColor()
        labelDesc?.font = UIFont.systemFontOfSize(12)
        
        labelTime?.textColor = UIColor.lightGrayColor()
        labelTime?.font = UIFont.systemFontOfSize(10)
        labelTime?.textAlignment = .Right
        
        contentView.addSubview(imgView!)
        contentView.addSubview(labelTitle!)
        contentView.addSubview(labelDesc!)
        contentView.addSubview(labelTime!)
        
        labelTitle?.text = "扫掉门前雪"
        labelDesc?.text = "这个是一个描述"
        labelTime?.text = "13:56"
        
        imgView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(10)
            make.width.equalTo(imgView!.snp_height)
        })
        
        labelTitle?.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(imgView!.snp_centerX).offset(-5)
            make.left.equalTo(imgView!.snp_right).offset(10)
            make.right.equalTo(-70)
            make.height.equalTo(16)
        })
        
        labelDesc?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(imgView!.snp_centerX).offset(5)
            make.left.equalTo(imgView!.snp_right).offset(10)
            make.right.equalTo(-10)
            make.height.equalTo(15)
        })
        
        labelTime?.snp_makeConstraints(closure: { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(imgView!.snp_centerX).offset(-10)
            make.width.equalTo(50)
            make.height.equalTo(10)
        })
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
