//
//  ChatEnum.swift
//  MiChat
//
//  Created by HuStan on 9/4/16.
//  Copyright © 2016 mikey. All rights reserved.
//

import UIKit

enum ChatMessageType:Int{
    case Text=0,//文本
    BigText,//大文本
    Emoji,//表情
    Image,//图片
    Video,//小视频
    RedPacket,//红包
    TransforAccount,//转账
    MyCollect,//收藏
    Location,//位置
    Voice//语音
}

