//
//  OAuthViewController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/7.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit
import SVProgressHUD


class OAuthViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavbar()
        
        loadRequest()
    }
}

//MARK:- setup
extension OAuthViewController{
    
    private func setupNavbar(){
        title = "授权登陆"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .Plain, target: self, action: #selector(navRightBtnClick))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: #selector(navLeftBtnClick))
    }
    
    private func loadRequest(){
        webView.delegate = self
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        guard let url = NSURL(string: urlString) else{
            return
        }
        let request = NSURLRequest(URL: url)
        
        webView.loadRequest(request)
    }
}

//MARK:- Actions
extension OAuthViewController{
    @objc private func navRightBtnClick(){
        let jsString = "document.getElementById('userId').value='18582057329';document.getElementById('passwd').value='xuhe123456';"
        
        webView.stringByEvaluatingJavaScriptFromString(jsString)
        
    }
    
    @objc private func navLeftBtnClick(){
        self.dismissViewControllerAnimated(true, completion: nil)
        SVProgressHUD.dismiss()
    }
}

//MARK:- UIWebViewDelegate
extension OAuthViewController: UIWebViewDelegate{
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
//        print(error)
//        SVProgressHUD.showErrorWithStatus("网络错误")
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.URL else{
            return true
        }
        
        let urlString = url.absoluteString
        
        guard urlString.containsString("code=") else{
            return true
        }
        SVProgressHUD.dismiss()
        let code = urlString.componentsSeparatedByString("code=").last!
        
        loadAccessToken(code)
        
        return false
    }
}

extension OAuthViewController{
    ///请求AccessToken
    private func loadAccessToken(code: String){
        NetWorkTools.shareInstance.requestAccessToken(code) { (result, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            guard let accountDict = result else {
                print("没有获取授权后的数据")
                return
            }
            
            let account = UserAccount(dict: accountDict)
            self.loadUserInfo(account)
            
        }
    }
    
    ///加载用户信息
    private func loadUserInfo(account: UserAccount){
        //获取accessToken
        guard let accessToken = account.access_token else{
            return
        }
        
        // uid
        guard let uid = account.uid else{
            return
        }
        
        //请求用户数据
        NetWorkTools.shareInstance.requestUserInfo(accessToken, uid: uid) { (result, error) in
            if error != nil {
                print(error)
                return
            }
            
            guard let userInfoDict = result else{
                return
            }
            
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            var accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
            accountPath = (accountPath as NSString).stringByAppendingPathComponent("account.plist")
            
            NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
            
            UserAccountModel.shareInstance.account = account
            
            //切换到Welcome
            self.dismissViewControllerAnimated(false, completion: { 
                UIApplication.sharedApplication().keyWindow?.rootViewController = WelComeViewController()
            })
        }
        
    }
}