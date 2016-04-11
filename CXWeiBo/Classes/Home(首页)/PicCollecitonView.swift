//
//  PicCollecitonView.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/10.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit
import SDWebImage


class PicCollecitonView: UICollectionView {
    //MARK:- 属性
    var picUrls = [NSURL](){
        didSet{
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dataSource = self
    }

}

//MARK:- UICollectionViewDataSource
extension PicCollecitonView:UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return picUrls.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCellWithReuseIdentifier("picCell", forIndexPath: indexPath) as? PicCollectionCell
        
        cell?.picUrl = picUrls[indexPath.item]
        
        return cell!
        
    }
    
}

class PicCollectionCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    var picUrl: NSURL?{
        didSet{
            iconView.sd_setImageWithURL(picUrl, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
}
