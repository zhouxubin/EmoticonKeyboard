//
//  String+Emoji.swift
//  EmotionKeyboardDemo
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 zhouxubin. All rights reserved.
//

import Foundation

extension String {
    
    func emoji() ->String {
        // 扫描16进制字符串
        let scanner = NSScanner(string: self)
        var value: UInt32 = 0
        scanner.scanHexInt(&value)
        let code = Character(UnicodeScalar(value))
        return "\(code)"
    }
    
}