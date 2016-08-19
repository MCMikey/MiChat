//
//  QFQTabBarButton.swift
//  Swift_Tab
//
//  Created by 黄星 on 15/9/1.
//  Copyright (c) 2015年 qingfanqie. All rights reserved.
//

import UIKit

class QFQTabBarButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var imgPoint = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imgPoint.frame = CGRectMake(40, 5, 10, 10)
        self.imgPoint.image = UIImage(named: "bg_red_point")
        self.imgPoint.hidden = true
        self.addSubview(self.imgPoint)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var point = self.imageView?.center
        point?.x = CGRectGetWidth(self.frame) / 2
        point?.y = CGRectGetHeight((self.imageView?.frame)!) / 2 + 4
        self.imageView?.center = point!
        
        var rect = self.titleLabel?.frame
        rect?.origin.x = 0
        rect?.origin.y = CGRectGetHeight((self.imageView?.frame)!) + 5
        rect?.size.width = self.frame.size.width
        
        self.titleLabel?.font = UIFont.systemFontOfSize(13)
        self.titleLabel?.frame = rect!
        self.titleLabel?.textAlignment = NSTextAlignment.Center
    }
    
    // 显示红点
    func hiddenView() {
        self.imgPoint.hidden = false
    }
    
    // 隐藏红点
    func hideView() {
        self.imgPoint.hidden = true
    }

}
