//
//  MovieDescriptionRouter.swift
//  DemoBelatrix
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

protocol MovieDescriptionRouterDelegate {
    
    func popController()
}

class MovieDescriptionRouter{
    
    private weak var viewController : MovieDescriptionViewController?
    
    init(viewController : MovieDescriptionViewController){
        self.viewController = viewController
    }
}

extension MovieDescriptionRouter : MovieDescriptionRouterDelegate{
    
    func popController() {
        guard let currentView = self.viewController else{return}
        currentView.navigationController?.popViewController(animated: true)
    }
}
