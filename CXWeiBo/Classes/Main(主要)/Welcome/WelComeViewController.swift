//
//  WelComeViewController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/8.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit
import SDWebImage

class WelComeViewController: UIViewController {
    /// 头像底部间距
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置头像
        setupIcon()
    }

}

//MARK:- Setup
extension WelComeViewController{
    private func setupIcon(){
        let iconUrlString = UserAccountModel.shareInstance.account?.avatar_large
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = iconView.frame.width * 0.5
        let url = NSURL(string: iconUrlString ?? "")
        
        iconView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar_default"))
        
        //动画
        iconViewBottomCons.constant = self.view.frame.height - 150
        
        UIView.animateWithDuration(3, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 3.0, options: [], animations: {
            self.view.layoutIfNeeded()
            }) { (_) in
                UIApplication.sharedApplication().keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
}
