//
//  PopoverAnimator.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/6.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {

}

extension PopoverAnimator: UIViewControllerTransitioningDelegate{
    //
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        let presentationController = CXPresentationController(presentedViewController: presented ,presentingViewController: presenting)
        
        
        return presentationController
    }
}
