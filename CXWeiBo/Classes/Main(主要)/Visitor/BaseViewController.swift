//
//  BaseViewController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/5.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    var isLogin : Bool = false
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
    }
}

extension BaseViewController{
    /// 设置访客视图
    private func setupVisitorView(){
        view = visitorView
        
        visitorView.registerBtn1.addTarget(self, action: #selector(BaseViewController.registerBtnClick), forControlEvents: .TouchUpInside)
        visitorView.loginBtn1.addTarget(self, action: #selector(BaseViewController.loginBtnClick), forControlEvents: .TouchUpInside)
    }
    
    /// 设置导航栏左右的Item
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: #selector(BaseViewController.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: #selector(BaseViewController.loginBtnClick))
    }
}

//MARK:- 监听事件
extension BaseViewController{
    @objc private func registerBtnClick(){
        CXLog("registerBtnClick")
    }
    
    @objc private func loginBtnClick(){
        CXLog("loginBtnClick")
    }
}