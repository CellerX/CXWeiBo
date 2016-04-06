//
//  VisitorView.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/5.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    // MARK:- 控件的属性
    
    @IBOutlet weak var loginBtn1: UIButton!
    @IBOutlet weak var registerBtn1: UIButton!
    @IBOutlet weak var rotationView1: UIImageView!
    @IBOutlet weak var iconView1: UIImageView!
    @IBOutlet weak var tipLabel1: UILabel!
    // MARK:- 提供快速通过xib创建的类方法
    class func visitorView() -> VisitorView{
        return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).first as! VisitorView
    }
    
    func setupVisitorViewInfo(iconName : String, title : String) {
        iconView1.image = UIImage(named: iconName)
        tipLabel1.text = title
        rotationView1.hidden = true
    }
    
    func addRotationAnim(){
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5.0
        rotationAnim.removedOnCompletion = false
        
        rotationView1.layer.addAnimation(rotationAnim, forKey: nil)
    }
}
