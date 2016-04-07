//
//  BarButtonItem+Extension.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/6.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit


extension UIBarButtonItem{
    convenience init(imageName: String) {
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        
        self.init(customView: btn)
    }
}
