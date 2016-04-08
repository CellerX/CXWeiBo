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
    private lazy var popoverAnimator : PopoverAnimator = PopoverAnimator()
    
    // MARK:- 系统回调函
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        guard UserAccountModel.shareInstance.isLogin else{
            visitorView.addRotationAnim()
            
            return
        }
        
        setupNavigationBar()
    }
}

extension HomeViewController{
    private func setupNavigationBar(){

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        navigationItem.titleView = titleBtn
        titleBtn.setTitle("CellerX", forState: .Normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), forControlEvents: .TouchUpInside)
        
    }
}

extension HomeViewController{
    /// 弹出popover菜单
    @objc private func titleBtnClick(){
        
        let popoverVC = PopoverViewController()
        //不移除之前控制器
        popoverVC.modalPresentationStyle = .Custom
        //设置转场动画代理
        popoverVC.transitioningDelegate = popoverAnimator
        
        self.presentViewController(popoverVC, animated: true, completion: nil)
        
    }
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate{
    
    
    
}
