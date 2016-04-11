//
//  MainViewController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/3.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController{
    
    private lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposeBtn()
        
    }
}

//MARK:- 设置界面
extension MainViewController{
    
    ///添加发布按钮
    private func setupComposeBtn(){
        tabBar.addSubview(composeBtn)
        composeBtn.center = CGPoint(x: tabBar.bounds.size.width * 0.5, y: tabBar.bounds.size.height * 0.5)
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClick), forControlEvents: .TouchUpInside)
    }
    
}

//MARK:- 事件

extension MainViewController{
    ///发布按钮
    @objc private func composeBtnClick(){
        let comVC = ComposeViewController()
        let navVC = UINavigationController(rootViewController: comVC)
        presentViewController(navVC, animated: true, completion: nil)
        
    }
}
