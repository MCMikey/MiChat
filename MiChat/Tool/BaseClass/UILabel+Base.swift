//
//  UILabel+Base.swift
//  LOLBox_Swift
//
//  Created by 黄星 on 15/12/11.
//  Copyright © 2015年 qingfanqie. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func getTextRectSize(label:UILabel, size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: label.font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = label.text!.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        //        println("rect:\(rect)");
        return rect;
    }
    
    static func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        //        println("rect:\(rect)");
        return rect;
    }
    
    
}
