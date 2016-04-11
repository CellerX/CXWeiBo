
//
//  HomeViewCellTableViewCell.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/9.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewCell: UITableViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var picView: PicCollecitonView!
    @IBOutlet weak var retweetedContentLabel: UILabel!
    @IBOutlet weak var retweetedBGView: UIView!
    @IBOutlet weak var toolBar: UIView!
    
    // MARK:- 约束的属性
    @IBOutlet weak var contentLabelWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picVIewHCons: NSLayoutConstraint!
    @IBOutlet weak var reContentViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var pickViewBottomCons: NSLayoutConstraint!
    // MARK:- 自定义属性
    var statusViewModel : StatusViewModel? {
        didSet {
            guard let viewModel = statusViewModel else {
                return
            }
            
            iconView.sd_setImageWithURL(viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default_small"))
            verifiedView.image = viewModel.verifiedImage
            screenNameLabel.text = viewModel.status?.user?.screen_name
            timeLabel.text = viewModel.createAtText
            contentLabel.text = viewModel.status?.text
            sourceLabel.text = viewModel.sourceText
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.blackColor() : UIColor.orangeColor()
            
            //计算picView的大小
            let picSize = calculatePicViewSize(viewModel.picURLs.count)
            picViewWCons.constant = picSize.width
            picVIewHCons.constant = picSize.height
    
            picView.picUrls = viewModel.picURLs
            
            //转发
            if viewModel.status?.retweeted_status != nil {
                reContentViewBottomCons.constant = margin10
                retweetedBGView.hidden = false
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name, retweetedText = viewModel.status?.retweeted_status?.text {
                    retweetedContentLabel.text = "@" + "\(screenName) :" + retweetedText
                }
            } else {
                retweetedContentLabel.text = nil
                retweetedBGView.hidden = true
                reContentViewBottomCons.constant = 0.0;
            }
            //处理约束
            if viewModel.picURLs.count == 0 {
                pickViewBottomCons.constant = 0.0
            }else{
                pickViewBottomCons.constant = margin10
            }
            
            //计算Cell高度
            if viewModel.cellHeight == 0{
                layoutIfNeeded()
                viewModel.cellHeight = CGRectGetMaxY(toolBar.frame) + 1
                
            }
        }
    }
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabelWCons.constant = UIScreen.mainScreen().bounds.width - 2 * 15.0
    }
}

//MARK:- 计算picView的大小
extension HomeViewCell{
    private func calculatePicViewSize(count: Int) -> CGSize{
        
        var picViewSize : CGSize = CGSizeZero
        
        let picViewW: CGFloat = UIScreen.mainScreen().bounds.width - margin15 * 2
        let cellWH = CGFloat((picViewW - margin10 * 2)) / 3.0
        
        let picViewLayout = picView.collectionViewLayout as? UICollectionViewFlowLayout
        picViewLayout?.itemSize = CGSizeMake(cellWH, cellWH)
        picViewLayout?.minimumLineSpacing = margin10
        picViewLayout?.minimumInteritemSpacing = margin10

        //没有配图
        if count == 0{
            return picViewSize
        }
        
        if count == 1{
            let imageString = statusViewModel?.picURLs.last?.absoluteString
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(imageString)
            let oneSize = CGSizeMake(image.size.width * 2, image.size.height * 2)
            picViewLayout?.itemSize = oneSize
            picViewSize = oneSize
            return picViewSize
        }
        
        //4张配图
        if count == 4{
            picViewSize = CGSizeMake(cellWH * 2 + margin10 + 1, cellWH * 2 + margin10)
            return picViewSize
        }
        
        //其他个数
        let rows = (count - 1) / 3 + 1
        let picViewH :CGFloat = CGFloat(rows) * cellWH + CGFloat(rows - 1) * margin10
        
        picViewSize = CGSizeMake(picViewW, picViewH)
        
        
        
        return picViewSize
    }
}
