//
//  TextView+Extension.swift
//  EmotionKeyboardDemo
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 zhouxubin. All rights reserved.
//

import UIKit

extension UITextView {
    
    func insertEmoticon(emoticon: XBEmoticon) {
        // 如果是删除按钮
        if emoticon.isDelete == true {
            deleteBackward()
            return
        }
        
        // 如果是空白表情
        if emoticon.isEmpty == true {
            return
        }
        
        // 如果是emoji表情的话
        if let emoji = emoticon.emojiStr {
            replaceRange(selectedTextRange!, withText: emoji)
            return
        }
        
        // 走到这里是图片表情,应该把图片添加到富文本的附件上
        let attachment = NSTextAttachment()
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        // 附件的高度
        let lineHeight = font?.lineHeight ?? 0
        attachment.bounds = CGRectMake(0, -4, lineHeight, lineHeight)
        // 图片文本
        let imageAttri = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        // 设置图片文本的字体属性
        imageAttri.addAttribute(NSFontAttributeName, value: font!, range: NSMakeRange(0, 1))
        let strM = NSMutableAttributedString(attributedString: attributedText)
        // 交换
        strM.replaceCharactersInRange(selectedRange, withAttributedString: imageAttri)
        // 记录交换前的光标
        let range = selectedRange
        attributedText = strM
        // 恢复光标位置
        selectedRange = NSMakeRange(range.location + 1, 0)
        
    }
    
}
