//
//  GrandCue.swift
//  GrandCueDemo
//
//  Created by HuStan on 3/14/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

class GrandCue: NSObject {
    private static let sharedInstance = GrandCue()
    class var sharedToast:GrandCue {
        return sharedInstance
    }
    var lbl:ToastLable?
    var window:UIWindow?
    static func toast(msg:String){
        GrandCue.sharedToast.showToast(msg)
    }
    
    static func toast(msg:String,verticalScale:Float){
        GrandCue.sharedToast.showToast(msg,verticalScale:verticalScale)
    }
    
    private func showToast(msg:String){
        self.showToast(msg,verticalScale:0.85)
    }

    
    private func showToast(msg:String,verticalScale:Float = 0.8){
        if lbl == nil{
            lbl = ToastLable(text: msg)
        }
        else{
            lbl?.text = msg
            lbl?.sizeToFit()
            lbl?.layer.removeAnimationForKey("animation")
        }
    
        window = UIApplication.sharedApplication().keyWindow
        
        if !(window!.subviews.contains(lbl!)){
            window?.addSubview(lbl!)
            lbl?.center = window!.center
            lbl?.frame.origin.y = UIScreen.mainScreen().bounds.height * CGFloat(verticalScale)
        }
        lbl?.addAnimationGroup()
    }
    
}





class ToastLable:UILabel {
    enum ToastShowType{
        case Top,Center,Bottom
    }
    var forwardAnimationDuration:CFTimeInterval = 0.3
    var backwardAnimationDuration:CFTimeInterval = 0.2
    var waitAnimationDuration:CFTimeInterval = 1.5
    var textInsets:UIEdgeInsets?
    var maxWidth:Float?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        maxWidth = Float(UIScreen.mainScreen().bounds.width) - 20.0
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.numberOfLines = 0
        self.textAlignment = NSTextAlignment.Left
        self.textColor = UIColor.whiteColor()
        self.font = UIFont.systemFontOfSize(14)
    }
    convenience init(text:String) {
        self.init(frame:CGRectZero)
        self.text = text
        self.sizeToFit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addAnimationGroup(){
        let forwardAnimation = CABasicAnimation(keyPath: "transform.scale")
        forwardAnimation.duration = self.forwardAnimationDuration
        forwardAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.7, 0.6, 0.85)
        forwardAnimation.fromValue = 0
        forwardAnimation.toValue = 1
        
        let backWardAnimation = CABasicAnimation(keyPath: "transform.scale")
        backWardAnimation.duration = self.backwardAnimationDuration
        backWardAnimation.beginTime = forwardAnimation.duration + waitAnimationDuration
        backWardAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.15, 0.5, -0.7)
        backWardAnimation.fromValue = 1
        backWardAnimation.toValue = 0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [forwardAnimation,backWardAnimation]
        animationGroup.duration = forwardAnimation.duration + backWardAnimation.duration + waitAnimationDuration
        animationGroup.removedOnCompletion = false
        animationGroup.delegate = self
        animationGroup.fillMode = kCAFillModeForwards
        self.layer.addAnimation(animationGroup, forKey: "animation")
    }
    override func sizeToFit() {
        super.sizeToFit()
        var fm = self.frame
        let width = CGRectGetWidth(self.bounds) + self.textInsets!.left + self.textInsets!.right
        fm.size.width = width > CGFloat(self.maxWidth!) ? CGFloat(self.maxWidth!) : width
        fm.size.height = CGRectGetHeight(self.bounds) + self.textInsets!.top + self.textInsets!.bottom
        fm.origin.x = UIScreen.mainScreen().bounds.width / 2 - fm.size.width / 2
        self.frame = fm
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if flag{
            self.removeFromSuperview()
        }
    }
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, self.textInsets!))
    }
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = bounds
        if let txt = self.text{
            rect.size =  (txt as NSString).boundingRectWithSize(CGSize(width: CGFloat(self.maxWidth!) - self.textInsets!.left - self.textInsets!.right, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:self.font], context: nil).size
        }
        return rect
    }
}



