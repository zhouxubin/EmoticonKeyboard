#EmotionKeyboard
---
一款用swift写的简单地自定义表情键盘,颜色支持自定义

下面是基本用法:

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
    
    // 懒加载这个控件,把这段代码拖进项目即可
    private lazy var emoticonView: XBEmoticonView = XBEmoticonView {[weak self] (emoticon) -> () in
        self?.textView.insertEmoticon(emoticon)
    }
}

---

###Image

![image](https://github.com/zhouxubin/EmoticonKeyboard/blob/master/image.png
 "背景颜色支持自定义")
