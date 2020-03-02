//
//  DemoNavigationControllerAnimated.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit

class DemoNavigationControllerAnimated : NSObject, UINavigationControllerDelegate{
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if (fromVC is HomeViewController && toVC is SearchMovieViewController) ||
           (fromVC is SearchMovieViewController && toVC is HomeViewController){
            return HomeToSearchMovieTransition(transitionMode: operation)
        } else if (fromVC is HomeViewController && toVC is MovieDescriptionViewController) ||
                  (fromVC is MovieDescriptionViewController && toVC is HomeViewController){
            return HomeToMovieDescriptionTransition(transitionMode: operation)
        } else if (fromVC is SearchMovieViewController && toVC is MovieDescriptionViewController) ||
                  (fromVC is MovieDescriptionViewController && toVC is SearchMovieViewController){
            return SearchMovieToMovieDescriptionTransition(transitionMode: operation)
        }
        
        return nil
    }
}


