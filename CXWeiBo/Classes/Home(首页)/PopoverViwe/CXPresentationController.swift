//
//  CXPresentationController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/6.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class CXPresentationController: UIPresentationController {

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //设置位置
        presentedView()?.frame = CGRect(x: 100, y: 60, width: 180, height: 250)
        
        //设置蒙版
        setupCoverView()
        
    }
    
}

extension CXPresentationController{
    private func setupCoverView(){
        let coverView = UIView()
        
        coverView.frame = containerView!.bounds
        coverView.backgroundColor = UIColor.init(white: 0.8, alpha: 0.3)
        
        
        
        //添加手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(coverClick))
        coverView.addGestureRecognizer(tapGesture)
        
        containerView?.insertSubview(coverView, belowSubview: presentedView()!)
    }
}

extension CXPresentationController{
    
    @objc private func coverClick(){
    
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
