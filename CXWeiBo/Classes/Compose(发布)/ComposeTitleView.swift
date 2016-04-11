//
//  ComposeTitleView.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/11.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTitleView: UIView {
    
    private lazy var titleLabel : UILabel = UILabel()
    private lazy var screenNameLabel : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK:- Setup
extension ComposeTitleView{
    
    private func setupUI() {
    
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        screenNameLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleLabel.snp_centerX)
            make.top.equalTo(titleLabel.snp_bottom).offset(3)
        }
        
        titleLabel.text = "发微博"
        screenNameLabel.text = UserAccountModel.shareInstance.account?.screen_name
        titleLabel.font = UIFont.systemFontOfSize(16)
        screenNameLabel.font = UIFont.systemFontOfSize(14)
        screenNameLabel.textColor = UIColor.lightGrayColor()
        
    }
}
