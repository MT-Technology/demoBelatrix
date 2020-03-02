//
//  xxx.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit

class HomeToSearchMovieTransition : NSObject, DemoViewControllerTransitionDelegate {
    
    var transitionMode: UINavigationController.Operation?
    
    required init(transitionMode : UINavigationController.Operation){
        self.transitionMode = transitionMode
    }
    
    func animatedToPush(withContext context: UIViewControllerContextTransitioning) {
        
        guard let sourceVC = context.viewController(forKey: .from) as? HomeViewController,
            let destinationVC = context.viewController(forKey: .to) as? SearchMovieViewController,
            let sourceView = context.view(forKey: .from),
            let destinationView = context.view(forKey: .to) else{
                context.completeTransition(false)
                return
        }
        
        let duration = transitionDuration(using: context)
        let containerView = context.containerView
        
        sourceView.frame = UIScreen.main.bounds
        destinationView.frame = UIScreen.main.bounds
        containerView.addSubview(sourceView)
        containerView.addSubview(destinationView)
        
        destinationView.layoutIfNeeded()
        sourceVC.searchButton.alpha = 0.0
        destinationVC.view.frame = UIScreen.main.bounds
        destinationVC.view.backgroundColor = .clear
        destinationVC.backButton.alpha = 0.0
        destinationVC.snapshotView.alpha = 0.0
        destinationVC.blurView.alpha = 0.0
        if let snapshot = sourceVC.view.snapshotView(afterScreenUpdates: true){
            destinationVC.snapshotView.addSubview(snapshot)
        }
        destinationVC.headerView.backgroundColor = .clear
        destinationVC.rightSearchBarConstraint.constant = -120.0
        destinationVC.leftSearchBarConstraint.constant = (UIScreen.main.bounds.width - 83.0)
        destinationView.layoutIfNeeded()
        
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeLinear, animations: {
         
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                sourceVC.searchButton.alpha = 0.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.7) {
                destinationVC.snapshotView.alpha = 1.0
                destinationVC.blurView.alpha = 1.0
                destinationVC.rightSearchBarConstraint.constant = 0.0
                destinationVC.leftSearchBarConstraint.constant = 5.0
                destinationView.layoutIfNeeded()
            }

            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 1.0) {
                destinationVC.backButton.alpha = 1.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 1, animations: {
                
                destinationVC.headerView.backgroundColor = UIColor(named: "redHeaderColor")
                
                destinationView.layoutIfNeeded()
            })
            
        }) { _ in
            context.completeTransition(true)
        }
    }
    
    func animatedToPop(withContext context: UIViewControllerContextTransitioning) {
        
    
        guard let sourceVC = context.viewController(forKey: .from) as? SearchMovieViewController,
            let destinationVC = context.viewController(forKey: .to) as? HomeViewController,
            let sourceView = context.view(forKey: .from),
            let destinationView = context.view(forKey: .to)
            else{
                context.completeTransition(false)
                return
        }

        let duration = transitionDuration(using: context)
        let containerView = context.containerView
        
        sourceView.frame = UIScreen.main.bounds
        destinationView.frame = UIScreen.main.bounds
        containerView.addSubview(destinationView)
        containerView.addSubview(sourceView)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeLinear, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.7) {
                sourceVC.backButton.alpha = 0.0
                sourceVC.snapshotView.alpha = 0.0
                sourceVC.blurView.alpha = 0.0
                sourceVC.moviesCollectionView.alpha = 0.0
                sourceVC.rightSearchBarConstraint.constant = -120.0
                sourceVC.leftSearchBarConstraint.constant = (UIScreen.main.bounds.width - 83.0)
                sourceVC.headerView.backgroundColor = .clear
                sourceView.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                destinationVC.searchButton.alpha = 1.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
                sourceVC.searchBar.alpha = 0.0
            }

        }) { _ in
            context.completeTransition(true)
        }
    }
}

extension HomeToSearchMovieTransition : UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch self.transitionMode {
        case .push:
            self.animatedToPush(withContext: transitionContext)
        case .pop:
            self.animatedToPop(withContext: transitionContext)
        default: break
        }
    }
}
