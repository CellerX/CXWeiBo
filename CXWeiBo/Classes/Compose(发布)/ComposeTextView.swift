//
//  ComposeTextView.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/11.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {

    lazy var placeHolderLabel : UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }

}

// MARK:- Setup
extension ComposeTextView {
    private func setupUI() {
        addSubview(placeHolderLabel)
        
        placeHolderLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(8)
            make.left.equalTo(10)
        }
        
        placeHolderLabel.textColor = UIColor.lightGrayColor()
        placeHolderLabel.font = font
        
        placeHolderLabel.text = "分享新鲜事..."
        
        textContainerInset = UIEdgeInsets(top: 8, left: 7, bottom: 0, right: 7)
    }
}
