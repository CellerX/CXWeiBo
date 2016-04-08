//
//  NetWorkTools.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/8.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit
import AFNetworking

enum HttpType : String {
    case GET = "GIT"
    case POST = "POST"
}

class NetWorkTools: AFHTTPSessionManager {

    //单例
    
    static let shareInstance : NetWorkTools = {
        let tools = NetWorkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
        
    }()
}

//MARK:- 封装AFN
extension NetWorkTools{
    
    func request(methodType: HttpType, urlString: String, params:[String : AnyObject], finished: (result: AnyObject?, error: NSError?) -> ()) {
        
        // 1.定义成功的回调闭包
        let successCallBack = { (task : NSURLSessionDataTask, result : AnyObject?) -> Void in
            finished(result: result, error: nil)
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task : NSURLSessionDataTask?, error : NSError) -> Void in
            finished(result: nil, error: error)
        }
        
        
        if methodType == .GET{
            GET(urlString, parameters: params, progress: nil, success: successCallBack, failure: failureCallBack)
        }else{
            POST(urlString, parameters: params, progress: nil, success: successCallBack, failure: failureCallBack)
        }
        
    }
}

//MARK:- 请求AccessToken

extension NetWorkTools{
    
    func requestAccessToken(code: String, finished:(result:[String : AnyObject]?, error: NSError?) -> ()){
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        // 2.获取请求的参数
        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        
        
        
        request(.POST, urlString: urlString, params: parameters, finished: { (result, error) in
            finished(result: result as? [String: AnyObject], error: error)
            
        })
        
            
    }
}

// MARK:- 请求用户的信息
extension NetWorkTools {
    func requestUserInfo(access_token : String, uid : String, finished : (result : [String : AnyObject]?, error : NSError?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        // 2.获取请求的参数
        let parameters = ["access_token" : access_token, "uid" : uid]
        
        // 3.发送网络请求
        request(.GET, urlString: urlString, params: parameters) { (result, error) -> () in
            finished(result: result as? [String : AnyObject] , error: error)
        }
    }
}


