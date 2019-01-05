//
//  SlideDownTransitionAnimator.swift
//  NavTransition
//
//  Created by Simon Ng on 19/10/2015.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit

class SlideDownTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 0.5
    var isPresenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // Get reference to our fromView, toView and the container view
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // Set up the transform we'll use in the animation
        guard let container = transitionContext.containerView() else {
            return
        }
        
        let offScreenUp = CGAffineTransformMakeTranslation(0, -container.frame.height)
        let offScreenDown = CGAffineTransformMakeTranslation(0, container.frame.height)
        
        // Make the toView off screen
        if isPresenting {
            toView.transform = offScreenUp
        }
        
        // Add both views to the container view
        container.addSubview(fromView)
        container.addSubview(toView)
        
        // Perform the animation
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            if self.isPresenting {
                fromView.transform = offScreenDown
                fromView.alpha = 0.5
                toView.transform = CGAffineTransformIdentity
            } else {
                fromView.transform = offScreenUp
                toView.alpha = 1.0
                toView.transform = CGAffineTransformIdentity
            }
            
        }, completion: { finished in
            
            transitionContext.completeTransition(true)
            
        })
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        isPresenting = false
        return self
    }
}
