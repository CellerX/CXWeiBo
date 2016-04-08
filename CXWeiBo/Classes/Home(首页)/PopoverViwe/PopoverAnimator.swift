//
//  PopoverAnimator.swift
//  CXWeiBo
//
//  Created by 河 徐 on 16/4/6.
//  Copyright © 2016年 CellerX. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    private var isPresented : Bool = false
}

extension PopoverAnimator: UIViewControllerTransitioningDelegate{
    
    
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        let presentationController = CXPresentationController(presentedViewController: presented ,presentingViewController: presenting)
        
        
        return presentationController
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = true;
        
        return self
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        
        return self
    }
}

extension PopoverAnimator: UIViewControllerAnimatedTransitioning{
    // 转场动画时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    // 设置转场动画
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? presentedAnimation(transitionContext) : dissmisAnimation(transitionContext)
    }
    
    //UITransitionContextFromViewKey, and UITransitionContextToViewKey
    private func presentedAnimation(transitionContext: UIViewControllerContextTransitioning){
        //获取弹出的view
        let presentedView: UIView? = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        //将view添加到容器视图
        transitionContext.containerView()?.addSubview(presentedView!)
        
        //设置动画
        presentedView?.alpha = 0
        //设置动画
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            presentedView?.alpha = 1.0
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
    }
    
    private func dissmisAnimation(transitionContext: UIViewControllerContextTransitioning){
        //获取弹出的view
        let presentedView: UIView? = transitionContext.viewForKey(UITransitionContextFromViewKey)
        
        //设置动画
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            presentedView?.alpha = 0
        }) { (_) in
            
            presentedView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
}
