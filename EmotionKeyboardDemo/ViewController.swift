//
//  ViewController.swift
//  EmotionKeyboardDemo
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 zhouxubin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.becomeFirstResponder()
        
        // toolbar的主题颜色(默认是亮灰色)
        emoticonView.toolbarColor = UIColor.redColor()
        // 键盘的背景颜色(默认是白色)
        emoticonView.keyboardColor = UIColor.blueColor()
        // MARK: 这里只需要设置UITextView的inputView就可以了
        textView.inputView = emoticonView
        
    }
    
    private lazy var emoticonView: XBEmoticonView = XBEmoticonView {[weak self] (emoticon) -> () in
        self?.textView.insertEmoticon(emoticon)
    }
}

