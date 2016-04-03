//
//  AppDelegate.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/3.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var defaultViewController : UIViewController {
        
        return MainViewController()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        //初始化窗口
        window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = defaultViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

