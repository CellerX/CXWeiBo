//
//  MainViewController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/3.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildVC()
        
    }
}



extension MainViewController{
    //MARK:- Setup
    func setupChildVC() {
        addChildViewController(HomeViewController(), iconName: "tabbar_home", title: "首页")
        addChildViewController(MessageVIewController(), iconName: "tabbar_message_center", title: "消息")
        addChildViewController(DiscoverVIewController(), iconName: "tabbar_discover", title: "发现")
        addChildViewController(ProfileViewController(), iconName: "tabbar_profile", title: "我")
    }
    
    //MARK:- ReloadMethod
    private func addChildViewController(childController: UIViewController, iconName: String, title: String) {
        
        childController.title = title
        childController.tabBarItem.image = UIImage(named: iconName)
        childController.tabBarItem.selectedImage = UIImage(named: iconName + "_highlighted")
        
        let childNav = UINavigationController.init(rootViewController: childController)
        
        addChildViewController(childNav)
    }
}