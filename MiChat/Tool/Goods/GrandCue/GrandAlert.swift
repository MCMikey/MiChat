//
//  GrandAlert.swift
//  GrandCueDemo
//
//  Created by HuStan on 3/14/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit


extension UIAlertView {
    static func setMessage(msg:String)->UIAlertView{
        let alert = BlockAlert()
        alert.message = msg
        return alert
    }
    
    func addAlertStyle(style:UIAlertViewStyle)->UIAlertView{
        self.alertViewStyle = style
        return self
    }
    
    func addTitle(title:String)->UIAlertView{
        self.title = title
        return self
    }
    
    func addFirstButton(btnTitle:String)->UIAlertView{
        self.addButtonWithTitle(btnTitle)
        return self
    }
    
    func addSecondButton(btnTitle:String)->UIAlertView{
        self.addButtonWithTitle(btnTitle)
        return self
    }
    
    func addButtons(btnTitles:[String])->UIAlertView{
        for title in btnTitles{
            self.addButtonWithTitle(title)
        }
        return self
    }
    
    func addButtonClickEvent(clickButton:((buttonIndex:Int,alert:UIAlertView)->Void)?)->UIAlertView{
        if let alert = self as? BlockAlert{
            alert.completion = clickButton
        }
        return self
    }
    
    func addDidDismissEvent(event:((buttonIndex:Int,alert:UIAlertView)->Void)?)->UIAlertView{
        if let alert = self as? BlockAlert{
            alert.didDismissBlock = event
        }
        return self
    }
    
    func addWillDismissEvent(event:((buttonIndex:Int,alert:UIAlertView)->Void)?)->UIAlertView{
        if let alert = self as? BlockAlert{
            alert.willDismissBlock = event
        }
        return self
    }
    
    
    func addDidPresentEvent(event:((alert:UIAlertView)->Void)?)->UIAlertView{
        if let alert = self as? BlockAlert{
            alert.didPresentBlock = event
        }
        return self
    }
    
    func addWillPresentEvent(event:((alert:UIAlertView)->Void)?)->UIAlertView{
        if let alert = self as? BlockAlert{
            alert.willPresentBlock = event
        }
        return self
    }
    
    func addAlertCancelEvent(event:((alert:UIAlertView)->Void)?)->UIAlertView{
        if let alert = self as? BlockAlert{
            alert.alertWithCalcelBlock = event
        }
        return self
    }
    
    
    func alertWithButtonClick(clickButton:((buttonIndex:Int,alert:UIAlertView)->Void)?){
        if let alert = self as? BlockAlert{
            alert.completion = clickButton
            alert.show()
        }
    }
}
class BlockAlert:UIAlertView,UIAlertViewDelegate {
    var completion:((buttonIndex:Int,alert:UIAlertView)->Void)?
    var willDismissBlock:((buttonIndex:Int,alert:UIAlertView)->Void)?
    var didDismissBlock:((buttonIndex:Int,alert:UIAlertView)->Void)?
    var didPresentBlock:((alert:UIAlertView)->Void)?
    var willPresentBlock:((alert:UIAlertView)->Void)?
    var alertWithCalcelBlock:((alert:UIAlertView)->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if let block = completion{
            block(buttonIndex: buttonIndex, alert: alertView)
        }
    }
    
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if let block = didDismissBlock{
            block(buttonIndex: buttonIndex, alert: alertView)
        }
    }
    
    func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        if let block = willDismissBlock{
            block(buttonIndex: buttonIndex, alert: alertView)
        }
        
    }
    
    
    func didPresentAlertView(alertView: UIAlertView) {
        if let block = didPresentBlock{
            block(alert: alertView)
        }
    }
    
    func willPresentAlertView(alertView: UIAlertView) {
        if let block = willPresentBlock{
            block(alert: alertView)
        }
    }
    
    func alertViewCancel(alertView: UIAlertView) {
        if let block = alertWithCalcelBlock{
            block(alert: alertView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIActionSheet{
    static func setTitle(title:String,cancelButtonTitle: String?, destructiveButtonTitle: String?)->UIActionSheet{
        let actionSheet = BlockActionSheet(title: title, cancelButtonTitle: cancelButtonTitle, destructiveButtonTitle: destructiveButtonTitle)
        return actionSheet
    }
    
    func setStyle(style:UIActionSheetStyle)->UIActionSheet{
        self.actionSheetStyle = style
        return self
    }
    
    func addButtons(btnTitles:[String])->UIActionSheet{
        for str in btnTitles{
            self.addButtonWithTitle(str)
        }
        return self
    }
    

    
    func showWithButtonClick(inView:UIView,clickButton:((buttonIndex:Int,actionSheet:UIActionSheet)->Void)?){
        if let actionSheet = self as? BlockActionSheet{
            actionSheet.completion = clickButton
            actionSheet.showInView(inView)
        }
    }
    
    func cancelClick(cancelClick:((actionSheet:UIActionSheet)->Void)?)->UIActionSheet{
        if let actionSheet = self as? BlockActionSheet{
            actionSheet.cancelBlock = cancelClick
            return actionSheet
        }
        return self
    }
    
    func willPresentEvent(event:((actionSheet:UIActionSheet)->Void)?)->UIActionSheet{
        if let actionSheet = self as? BlockActionSheet{
            actionSheet.willPresentBlock = event
            return actionSheet
        }
        return self
    }
    func didPresentEvent(event:((actionSheet:UIActionSheet)->Void)?)->UIActionSheet{
        if let actionSheet = self as? BlockActionSheet{
            actionSheet.didPresentBlock = event
            return actionSheet
        }
        return self
    }
    func willDidmissEvent(event:((buttonIndex:Int,actionSheet:UIActionSheet)->Void)?)->UIActionSheet{
        if let actionSheet = self as? BlockActionSheet{
            actionSheet.willDidmissBlock = event
            return actionSheet
        }
        return self
    }
    
    func didDidmissEvent(event:((buttonIndex:Int,actionSheet:UIActionSheet)->Void)?)->UIActionSheet{
        if let actionSheet = self as? BlockActionSheet{
            actionSheet.didDissmissBlock = event
            return actionSheet
        }
        return self
    }
    
}


class BlockActionSheet: UIActionSheet,UIActionSheetDelegate {
     var completion:((buttonIndex:Int,actionSheet:UIActionSheet)->Void)?
    var cancelBlock:((actionSheet:UIActionSheet)->Void)?
    var willPresentBlock:((actionSheet:UIActionSheet)->Void)?
    var didPresentBlock:((actionSheet:UIActionSheet)->Void)?
    var willDidmissBlock:((buttonIndex:Int,actionSheet:UIActionSheet)->Void)?
    var didDissmissBlock:((buttonIndex:Int,actionSheet:UIActionSheet)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
     init(title: String?, cancelButtonTitle: String?, destructiveButtonTitle: String?) {
        super.init(title: title, delegate: nil, cancelButtonTitle: cancelButtonTitle, destructiveButtonTitle: destructiveButtonTitle)
        self.delegate = self
    }

    
    
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if let block = completion{
            block(buttonIndex: buttonIndex, actionSheet: actionSheet)
        }
    }
    
    func actionSheetCancel(actionSheet: UIActionSheet) {
        if let block = cancelBlock{
            block(actionSheet: actionSheet)
        }
    }
    
    func willPresentActionSheet(actionSheet: UIActionSheet) {
        if let block = willPresentBlock{
            block(actionSheet: actionSheet)
        }
    }
    
    func didPresentActionSheet(actionSheet: UIActionSheet) {
        if let block = didPresentBlock{
            block(actionSheet: actionSheet)
        }
    }
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        if let block = willDidmissBlock{
            block(buttonIndex: buttonIndex, actionSheet: actionSheet)
        }
    }
    func actionSheet(actionSheet: UIActionSheet, willDismissWithButtonIndex buttonIndex: Int) {
        if let block = didDissmissBlock{
            block(buttonIndex: buttonIndex, actionSheet: actionSheet)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIAlertController{
    func action(action:UIAlertAction)->UIAlertController{
        self.addAction(action)
        return self
    }
    
    func show(viewController:UIViewController){
        viewController.presentViewController(self, animated: true, completion: nil)
    }
    
}