//
//  MiSocketServe.swift
//  MiChat
//
//  Created by Mikey on 16/8/19.
//  Copyright © 2016年 mikey. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

enum SocketOffline {
    case ByServer // 服务器掉线，默认为0
    case ByUser   // 用户主动cut
}

class MiSocketServe: NSObject {

    // 单例
    static let sharedInstance = MiSocketServe()
    private override init() {}
    
    var asyncSocket: GCDAsyncSocket!
    
    var host: String = ""
    var port: UInt16 = 0
    var mainQueue = dispatch_get_main_queue()
    var timer: NSTimer!

    /// socket连接
    func socketConnectHost(host: String, port: UInt16) {
        asyncSocket = GCDAsyncSocket(delegate: self, delegateQueue:dispatch_get_global_queue(0,0))
        do {
            try asyncSocket?.connectToHost(host, onPort: port)
        } catch {
            print("error")
        }
    }
    
    /// 发送信息
    func sendMsg(msg: String, tag: Int) {
        print("发送出去的信息 = \(msg)")
        let data = msg.dataUsingEncoding(NSUTF8StringEncoding)
        if data != nil {
            asyncSocket.writeData(data!, withTimeout: -1, tag: tag)
        }
    }
    
    /// 检查连接
    func checkConnect() {
        print("checkConnect")
        let longConnect = "longConnect"
        let data = longConnect.dataUsingEncoding(NSUTF8StringEncoding)
        asyncSocket.writeData(data!, withTimeout: 1, tag: 1)
    }

    /// 断开连接
    func cutOffConnect() {
        timer.invalidate()
        asyncSocket.disconnect()
    }
}

extension MiSocketServe: GCDAsyncSocketDelegate {
    
    //MARK:- 服务器连接成功
    func socket(sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("连接 socket = \(sock), host = \(host), port = \(port)")
        self.port = port
        self.host = host
        asyncSocket?.readDataWithTimeout(-1, tag: 0)
        
        // 隔段时间发送心跳包
//        timer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: #selector(checkConnect), userInfo: nil, repeats: true)
//        timer.fire()
    }
    
    //MARK:- 服务器断开连接
    func socketDidDisconnect(sock: GCDAsyncSocket, withError err: NSError?) {
        print("与服务器断开 err = \(err) data = \(sock.userData)")
        socketConnectHost(host, port: port)
    }
    
    //MARK:- data读取
    func socket(sock: GCDAsyncSocket, didReadData data: NSData, withTag tag: Int) {
        let readClientDataString:NSString? = NSString(data: data, encoding:NSUTF8StringEncoding)
        print(readClientDataString!)
        
        dispatch_async(mainQueue, {
            print("回到主线程")
        })
        
        let serviceStr:NSMutableString = NSMutableString()
        serviceStr.appendString("ok\n")
        asyncSocket.writeData(serviceStr.dataUsingEncoding(NSUTF8StringEncoding)!, withTimeout: -1, tag: 0)
        asyncSocket.readDataWithTimeout(-1, tag:0)
    }
}

