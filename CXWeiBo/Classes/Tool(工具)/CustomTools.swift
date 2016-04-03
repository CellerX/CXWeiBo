//
//  CustomTools.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/3.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

//MARK:- CustomLog
func CXLog<T>(message: T, fileName: String = #file, lineNum: Int = #line) {
    
    #if DEBUG
        
        let file = (fileName as NSString).lastPathComponent
        print("\(file):[\(lineNum)]-\(message)")
        
    #endif
}

