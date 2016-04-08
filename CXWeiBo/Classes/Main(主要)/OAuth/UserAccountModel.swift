//
//  UserAccountModel.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/8.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class UserAccountModel{
    
    //单例
    static let shareInstance: UserAccountModel = UserAccountModel()
    
    var account: UserAccount?
    
    //归档地址
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        return (accountPath as NSString).stringByAppendingPathComponent("account.plist")
    }
    
    var isLogin: Bool{
        if account == nil{
            return false
        }
        
        guard let expriesDate = account?.expires_date else{
            return false
        }
        
        return expriesDate.compare(NSDate()) == NSComparisonResult.OrderedDescending
    }
    
    init() {
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
    }
}
