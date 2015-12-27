//
//  XBEmoticonManager.swift
//  EmotionKeyboardDemo
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 zhouxubin. All rights reserved.
//

import UIKit

class XBEmoticonManager: NSObject {
    
    // 定义外部模型属性
    var packges = [XBEmoticonPackge]()

    override init() {
        super.init()
        loadEmoticonPackge()
    }
    
    // MARK: 加载表情数据
    private func loadEmoticonPackge() {
        let path = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + "emoticons.plist"
        let dict = NSDictionary(contentsOfFile: path)!
        if let array = dict["packages"] as? [[String : AnyObject]] {
            // 遍历数组
            for item in array {
                let id = item["id"] as! String
                // 根据id路径去加载不同路径下地plist文件
                loadPlist(id)
            }
        }
    }
    
    private func loadPlist(id: String) {
        let path = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + id + "/info.plist"
        let dict = NSDictionary(contentsOfFile: path)!
        // 取出表情名字
        let emoticonName = dict["group_name_cn"] as! String
        // 取出表情数组
        let emoticonArr = dict["emoticons"] as! [[String : String]]
        let p = XBEmoticonPackge(idPath: id, emoticonName: emoticonName, emoticonsArr: emoticonArr)
        packges.append(p)
    }
}
