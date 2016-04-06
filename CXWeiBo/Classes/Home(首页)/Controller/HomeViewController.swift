//
//  HomeViewController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/3.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    private lazy var titleBtn : TitleButton = TitleButton()
    
    // MARK:- 系统回调函
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        guard isLogin else{
            visitorView.addRotationAnim()
            return
        }
        
        setupNavigationBar()
    }
}

extension HomeViewController{
    private func setupNavigationBar(){
        
    }
}
