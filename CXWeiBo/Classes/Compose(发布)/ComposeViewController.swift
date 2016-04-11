//
//  ComposeViewController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/11.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    //MARK:- 控件属性
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var composeTextView: ComposeTextView!
    
    //MARK:- 约束属性
    @IBOutlet weak var toolbarBottomCons: NSLayoutConstraint!
    
    //MARK:- 懒加载
    private lazy var titleView : ComposeTitleView = ComposeTitleView()
    
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
        composeTextView.delegate = self
        
    }

}

//MARK:- Setup
extension ComposeViewController{
    /// 设置导航栏
    private func setupNav(){
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: #selector(sendItemClick))
        navigationItem.rightBarButtonItem?.enabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        navigationItem.titleView = titleView
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    /// 键盘改变通知
    @objc private func keyboardWillChange(notice: NSNotification){
        let keyboardFrame = notice.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        toolbarBottomCons.constant = UIScreen.mainScreen().bounds.height - keyboardFrame.origin.y
    }
}


// MARK:- Actions
extension ComposeViewController {
    @objc private func closeItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func sendItemClick() {
        
        composeTextView.resignFirstResponder()
    }
    
}

extension ComposeViewController: UITextViewDelegate{
    
    func textViewDidChange(textView: UITextView) {
        if textView.text.isEmpty{
            navigationItem.rightBarButtonItem?.enabled = false
            composeTextView.placeHolderLabel.hidden = false
        }else{
            navigationItem.rightBarButtonItem?.enabled = true
            composeTextView.placeHolderLabel.hidden = true
        }
    }
    
}
