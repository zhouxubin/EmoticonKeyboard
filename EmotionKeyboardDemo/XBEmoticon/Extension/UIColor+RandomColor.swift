//
//  UIColor+RandomColor.swift
//  EmotionKeyboardDemo
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 zhouxubin. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func randomColor() ->UIColor {
        let r = CGFloat(random() % 256) / 255.0
        let g = CGFloat(random() % 256) / 255.0
        let b = CGFloat(random() % 256) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}
