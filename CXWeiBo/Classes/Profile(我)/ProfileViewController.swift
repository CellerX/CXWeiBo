//
//  ProfileViewController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/3.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorViewInfo("visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
    }
}
