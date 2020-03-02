//
//  DemoAnimatedTransitionDelegate.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit

protocol DemoViewControllerTransitionDelegate {
    
    var transitionMode : UINavigationController.Operation? {get set}
    
    init(transitionMode : UINavigationController.Operation)
    
    func animatedToPush(withContext context : UIViewControllerContextTransitioning)
    func animatedToPop(withContext context: UIViewControllerContextTransitioning)
}
