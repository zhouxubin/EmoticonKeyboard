//
//  XBEmoticon.swift
//  EmotionKeyboardDemo
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 zhouxubin. All rights reserved.
//

import UIKit

class XBEmoticon: NSObject {

    // 表情路径
    var id: String?
    
    // emoji表情
    var code: String?
    
    // emoji字符串
    var emojiStr: String? {
        return code?.emoji()
    }
    
    // 表情名字
    var chs: String?
    
    // 表情图片
    var png: String?
    
    // 表情图片路径
    var pngPath: String? {
        let idPath = (id ?? "") + "/"
        let fileName = png ?? ""
        return NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + idPath + fileName
    }
    
    // 删除按钮
    var isDelete: Bool?
    
    // 空白表情
    var isEmpty: Bool?
    
    // MARK: 构造方法
    init(dic: [String : String]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    init(delete: Bool) {
        self.isDelete = delete
    }
    
    init(empty: Bool) {
        self.isEmpty = empty
    }
    
    // 过滤掉不要的key
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    // 重写description方法
    override var description: String {
        let keys = ["id", "code", "chs", "png"]
        return dictionaryWithValuesForKeys(keys).description
    }
}
