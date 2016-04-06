//
//  UIButton-Extension.swift
//  DSWB
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(imageName : String, bgImageName : String) {
        self.init()
        
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), forState: .Highlighted)
        sizeToFit()
    }
    
    convenience init(title : String, bgColor : UIColor, fontSize : CGFloat) {
        self.init()
        
        setTitle(title, forState: .Normal)
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }

}