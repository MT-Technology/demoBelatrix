//
//  SearchMovieToMovieDescriptionTransition.swift
//  DemoBelatrix
//
//  Created by everis on 3/2/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit

class SearchMovieToMovieDescriptionTransition: NSObject, DemoViewControllerTransitionDelegate {
    
    var transitionMode: UINavigationController.Operation?
    
    required init(transitionMode: UINavigationController.Operation) {
        self.transitionMode = transitionMode
    }
    
    func animatedToPush(withContext context: UIViewControllerContextTransitioning) {
        
        guard let sourceVC = context.viewController(forKey: .from) as? SearchMovieViewController,
            let destinationVC = context.viewController(forKey: .to) as? MovieDescriptionViewController,
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
        
        var posterImageView : UIImageView?
        for cell in sourceVC.moviesCollectionView.visibleCells{
            if cell.isSelected{
                let movieCell = cell as! MovieCollectionViewCell
                
                posterImageView = UIImageView(frame: movieCell.convert(movieCell.bounds, to: sourceView))
                posterImageView?.image = movieCell.movieImageView.image
                posterImageView?.alpha = 0.0
                containerView.addSubview(posterImageView!)
            }
        }
        
        destinationView.layoutIfNeeded()
        let backdropHeight = ((UIScreen.main.bounds.width/320.0) * 180.0).rounded()
        let centre_y = (backdropHeight + destinationView.safeAreaInsets.top + 44.0 + (posterImageView!.frame.height * 0.4).rounded()) - (posterImageView!.frame.height/2)
        
        destinationView.backgroundColor = .clear
        destinationVC.headerView.backgroundColor = .clear
        destinationVC.posterImageView.alpha = 0.0
        destinationVC.backButton.alpha = 0.0
        destinationVC.titleLabel.alpha = 0.0
        destinationVC.scrollViewDescription.alpha = 0.0
        destinationView.layoutIfNeeded()
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4) {
                sourceVC.backButton.alpha = 0.0
                sourceVC.searchBar.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.7) {
                
                sourceVC.moviesCollectionView.alpha = 0.0
                posterImageView?.center = CGPoint(x: destinationVC.posterImageView.center.x,
                                                        y: centre_y)
                posterImageView?.alpha = 1.0
                posterImageView?.layer.borderWidth = 3
                posterImageView?.layer.borderColor = UIColor(named: "redHeaderColor")?.cgColor
                destinationVC.scrollViewDescription.alpha = 1.0
            }
            
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.5, animations: {
                
                destinationVC.headerView.backgroundColor = UIColor(named: "redHeaderColor")
                destinationVC.backButton.alpha = 1.0
                destinationVC.titleLabel.alpha = 1.0
                destinationView.layoutIfNeeded()
            })
            
        }) { _ in
            destinationVC.posterImageView.alpha = 1.0
            posterImageView?.removeFromSuperview()
            context.completeTransition(true)
        }
        
    }
    
    func animatedToPop(withContext context: UIViewControllerContextTransitioning) {
        
        guard let sourceVC = context.viewController(forKey: .from) as? MovieDescriptionViewController,
            let destinationVC = context.viewController(forKey: .to) as? SearchMovieViewController,
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
        
        let posterImageView = UIImageView(frame: sourceVC.posterImageView.convert(sourceVC.posterImageView.bounds, to: sourceView))
        posterImageView.image = sourceVC.posterImageView.image
        containerView.addSubview(posterImageView)
        
        sourceVC.headerView.backgroundColor = .clear
        sourceVC.posterImageView.alpha = 0.0
        var cellCenter : CGPoint?
        for cell in destinationVC.moviesCollectionView.visibleCells{
            if cell.isSelected{
                
                let movieCell = cell as! MovieCollectionViewCell
                let view = UIImageView(frame: movieCell.convert(movieCell.bounds, to: destinationView))
                cell.isSelected = false
                cellCenter = view.center
            }
        }
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4) {
                sourceVC.titleLabel.alpha = 0.0
                sourceVC.backButton.alpha = 0.0
                sourceVC.scrollViewDescription.alpha = 0.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.5) {
                destinationVC.backButton.alpha = 1.0
                destinationVC.searchBar.alpha = 1.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.7) {
                
                destinationVC.moviesCollectionView.alpha = 1.0
                posterImageView.center = cellCenter!
                posterImageView.alpha = 0.0
                posterImageView.layer.borderWidth = 0
            }
            
        }) { _ in
            posterImageView.removeFromSuperview()
            context.completeTransition(true)
        }
    }
}

extension SearchMovieToMovieDescriptionTransition : UIViewControllerAnimatedTransitioning{
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
