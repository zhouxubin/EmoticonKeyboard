//
//  XBEmoticonPackge.swift
//  EmotionKeyboardDemo
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 zhouxubin. All rights reserved.
//

import UIKit

class XBEmoticonPackge: NSObject {

    // 表情名字
    var group_name_cn: String?
    
    // 表情路径
    var id: String?
    
    // 表情数组
    var emoticons = [XBEmoticon]()
    
    // MARK: 构造函数
    init(idPath: String, emoticonName: String, emoticonsArr: [[String : String]]) {
        super.init()
        self.id = idPath
        self.group_name_cn = emoticonName
        // 遍历字典数组
        var index = 0
        for dict in emoticonsArr {
            let emo = XBEmoticon(dic: dict)
            emo.id = idPath
            emoticons.append(emo)
            // 在20个位置的地方添加一个删除按钮
            index++
            if index == 20 {
                let deleteEmoji = XBEmoticon(delete: true)
                emoticons.append(deleteEmoji)
                // 及时归零
                index = 0
            }
        }
        // 在不足一页的表情页的地方添加空白表情
        let count = emoticons.count % 21
        if count == 0 {
            return
        }
        
        for _ in count..<20 {
            let emo = XBEmoticon(empty: true)
            emoticons.append(emo)
        }
        // 添加一个删除按钮
        emoticons.append(XBEmoticon(delete: true))
    }
}
