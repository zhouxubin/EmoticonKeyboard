//
//  XBEmoticonViewCell.swift
//  EmotionKeyboardDemo
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 zhouxubin. All rights reserved.
//

import UIKit

class XBEmoticonViewCell: UICollectionViewCell {
    
    // 定义外部模型属性,给属性赋值
    var emoticon: XBEmoticon? {
        didSet {
            button.setImage(UIImage(contentsOfFile: emoticon?.pngPath ?? ""), forState: UIControlState.Normal)
            button.setTitle(emoticon?.emojiStr, forState: UIControlState.Normal)
            if emoticon?.isDelete == true { // 删除按钮
                button.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
                button.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 初始化子控件
        setUpUI()
    }
    
    // 初始化子控件
    private func setUpUI() {
        contentView.addSubview(button)
        
        // 设置约束
        button.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView)
        }
    }
    
    // MARK: 懒加载
    private var button: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFontOfSize(32)
        btn.userInteractionEnabled = false
        return btn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
