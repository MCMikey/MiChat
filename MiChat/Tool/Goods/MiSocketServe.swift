//
//  MiSocketServe.swift
//  MiChat
//
//  Created by Mikey on 16/8/19.
//  Copyright © 2016年 mikey. All rights reserved.
//

import UIKit

enum SocketOffline {
    case ByServer // 服务器掉线，默认为0
    case ByUser   // 用户主动cut
}

class MiSocketServe: NSObject {

    // 单例
    static let sharedInstance = MiSocketServe()
    private override init() {}
    
    
    func socketConnectHost() {
        
    }
}
