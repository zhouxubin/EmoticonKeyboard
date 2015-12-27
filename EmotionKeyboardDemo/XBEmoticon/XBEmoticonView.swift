//
//  XBEmoticonView.swift
//  EmotionKeyboardDemo
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 zhouxubin. All rights reserved.
//

import UIKit

private let emoticonKeyboardWidth: CGFloat = UIScreen.mainScreen().bounds.width
private let emoticonKeyboardHeight: CGFloat = 216
private let maxEmoticonCount: CGFloat = 7
private let emoticonKeyboardMargin: CGFloat = 8
private let reuseIdentifer = "cell"

class XBEmoticonView: UIView {
    
    /// toolbar的主题颜色
    var toolbarColor: UIColor? {
        didSet {
            toolbar.tintColor = toolbarColor
        }
    }
    
    /// 键盘的背景颜色
    var keyboardColor: UIColor? {
        didSet {
            emoticon.backgroundColor = keyboardColor
        }
    }
    
    // toolbar的点击事件
    @objc private func clickToolbar(item: UIBarButtonItem) {
        let indexPath = NSIndexPath(forItem: 0, inSection: item.tag)
        emoticon.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    
    // 回调闭包
    private var emoticonBlock: ((emoticon: XBEmoticon)->())?
    
    // 模型数组
    private var emoticonPackge = XBEmoticonManager().packges

    init(clickEmoticon: ((emoticon: XBEmoticon)->())) {
        let rect = CGRect(x: 0, y: 0, width: emoticonKeyboardWidth, height: emoticonKeyboardHeight)
        super.init(frame: rect)
        // 回调闭包
        emoticonBlock = clickEmoticon
        // 初始化子控件
        setUpUI()
    }
    
    // MARK: 初始化子控件
    private func setUpUI() {
        addSubview(toolbar)
        addSubview(emoticon)
        
        // 设置约束
        toolbar.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(35)
        }
        
        // 表情view
        emoticon.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(toolbar.snp_top)
        }
        
        // 设置toolbar
        setUpToolbar()
    }
    
    // 设置toolbar
    private func setUpToolbar() {
        // 遍历表情包数组,设置item的分组
        var itemArr = [UIBarButtonItem]()
        var index = 0
        for packge in emoticonPackge {
            let item = UIBarButtonItem(title: packge.group_name_cn, style: UIBarButtonItemStyle.Plain, target: self, action: "clickToolbar:")
            item.tag = index++
            itemArr.append(item)
            // 添加一个弹簧
            itemArr.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
        }
        // 取出最后一个弹簧
        itemArr.removeLast()
        toolbar.items = itemArr
    }
    
    // 懒加载
    // 工具栏
    private lazy var toolbar: UIToolbar = {
        let t = UIToolbar()
        t.tintColor = UIColor.lightGrayColor()
        return t
    }()
    
    // 表情视图
    private lazy var emoticon: UICollectionView = {
        // 布局
        let flowlayout = UICollectionViewFlowLayout()
        // 设置布局的属性
        let itemWH = emoticonKeyboardWidth / maxEmoticonCount
        flowlayout.itemSize = CGSizeMake(itemWH, itemWH)
        flowlayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.minimumLineSpacing = 0
        flowlayout.sectionInset = UIEdgeInsets(top: emoticonKeyboardMargin, left: 0, bottom: emoticonKeyboardMargin, right: 0)
        // 集合视图
        let emotic = UICollectionView(frame: CGRectZero, collectionViewLayout: flowlayout)
        emotic.backgroundColor = UIColor.whiteColor()
        emotic.dataSource = self
        emotic.delegate = self
        emotic.pagingEnabled = true
        // 注册cell
        emotic.registerClass(XBEmoticonViewCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        return emotic
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension XBEmoticonView: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return emoticonPackge.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emoticonPackge[section].emoticons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifer, forIndexPath: indexPath) as! XBEmoticonViewCell
        cell.emoticon = emoticonPackge[indexPath.section].emoticons[indexPath.item]
        return cell
    }
}

extension XBEmoticonView: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 点击表情只要把表情模型传递出去就可以了
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! XBEmoticonViewCell
        emoticonBlock?(emoticon: cell.emoticon!)
    }
}
    