//
//  HomeViewController.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/3.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class HomeViewController: BaseViewController {

    private lazy var titleBtn : TitleButton = TitleButton()
    private lazy var popoverAnimator : PopoverAnimator = PopoverAnimator()
    private lazy var statusViewModels: [StatusViewModel] = [StatusViewModel]()
    //刷新提示
    private lazy var tipLabel : UILabel = UILabel()
    
    // MARK:- 系统回调函
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard UserAccountModel.shareInstance.isLogin else{
            visitorView.addRotationAnim()
            return
        }
        //设置导航栏
        setupNavigationBar()

        
        //自动计算Cell高度
        
        tableView.estimatedRowHeight = 200
        
        //设置刷新
        setupHeaderView()
        setupFooterView()
    }
}

//MARK:- Setup
extension HomeViewController{
    private func setupNavigationBar(){

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        navigationItem.titleView = titleBtn
        titleBtn.setTitle("CellerX", forState: .Normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), forControlEvents: .TouchUpInside)
        
        setupLabel()
    }
    
    private func setupHeaderView(){
        let header = MJRefreshNormalHeader { 
            self.loadNewData()
        }
        
        header.setTitle("下拉刷新", forState: .Idle)
        header.setTitle("释放更新", forState: .Pulling)
        header.setTitle("加载中...", forState: .Refreshing)
        
        tableView.mj_header = header
        
        tableView.mj_header.beginRefreshing()
    }
    
    private func setupFooterView(){
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.loadMoreData()
        })
    }
    
    private func setupLabel(){
        navigationController?.navigationBar.insertSubview(tipLabel, atIndex: 0)
        
        tipLabel.frame = CGRect(x: 0, y: 10, width: UIScreen.mainScreen().bounds.width, height: 32)
        
        tipLabel.backgroundColor = UIColor.orangeColor()
        tipLabel.textColor = UIColor.whiteColor()
        tipLabel.font = UIFont.systemFontOfSize(14)
        tipLabel.textAlignment = .Center
        tipLabel.hidden = true
    }
}

//MARK:- LoadData
extension HomeViewController{
    
    private func loadNewData(){
        loadStatusData(true)
    }
    
    private func loadMoreData(){
        loadStatusData(false)
    }
    
    private func loadStatusData(isNewData: Bool){

        var since_id = 0
        var max_id = 0
        if isNewData {
            since_id = statusViewModels.first?.status?.mid ?? 0
        }else{
            max_id = statusViewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        NetWorkTools.shareInstance.requestStatuses (since_id, max_id: max_id){(result, error) in
            if error != nil{
                print(error)
                return
            }
            
            guard let resultArray = result else{
                return
            }
            
            var tempViewModel = [StatusViewModel]()
            for statusDict in resultArray{
                let status = Status(dict: statusDict)
                let statusViewModel = StatusViewModel(status: status)
                tempViewModel.append(statusViewModel)
            }
            
            if isNewData{
                self.statusViewModels = tempViewModel + self.statusViewModels
            }else{
                self.statusViewModels += tempViewModel
            }
            
            self.loadCachePic(self.statusViewModels, newCount: tempViewModel.count)
            
        }
    }
    
    private func loadCachePic(viewModels: [StatusViewModel],newCount: Int){
        let group = dispatch_group_create()
        
        for viewModel in viewModels{
            for picUrl in viewModel.picURLs{
                dispatch_group_enter(group)
                SDWebImageManager.sharedManager().downloadImageWithURL(picUrl, options: [], progress: nil, completed: { (_, _, _, _, _) in
                    dispatch_group_leave(group)
                })
            }
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { 
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            self.showTipLabel(newCount)
        }
    }
    
    private func showTipLabel(count : Int){
        tipLabel.hidden = false
        tipLabel.text = count == 0 ? "没有新数据" : "\(count) 条新微博"
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.tipLabel.frame.origin.y = 44
        }) { (_) -> Void in
            UIView.animateWithDuration(1.0, delay: 1.5, options: [], animations: { () -> Void in
                self.tipLabel.frame.origin.y = 10
                }, completion: { (_) -> Void in
                    self.tipLabel.hidden = true
            })
        }
    }
}

extension HomeViewController{
    /// 弹出popover菜单
    @objc private func titleBtnClick(){
        
        let popoverVC = PopoverViewController()
        //不移除之前控制器
        popoverVC.modalPresentationStyle = .Custom
        //设置转场动画代理
        popoverVC.transitioningDelegate = popoverAnimator
        
        self.presentViewController(popoverVC, animated: true, completion: nil)
        
    }
}

extension HomeViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusViewModels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 1.创建cell
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! HomeViewCell
        
        // 2.给cell设置数据
        cell.statusViewModel = statusViewModels[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return statusViewModels[indexPath.row].cellHeight
    }
}


