//
//  MovieDescriptionPresenter.swift
//  DemoBelatrix
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation
import DemoInteractor
    
protocol MovieDescriptionPresenterDelegate : class{
    
    func popController()
    func getMovieDescription(withMovieId movieId : Int)
}

class MovieDescriptionPresenter {

    private weak var viewController : MovieDescriptionViewControllerDelegate?
    private var interactor : MovieDescriptionInteractorDelegate
    private var router : MovieDescriptionRouterDelegate
    
    init(viewController : MovieDescriptionViewControllerDelegate,
         interactor : MovieDescriptionInteractor,
         router : MovieDescriptionRouter){
        
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
}

extension MovieDescriptionPresenter : MovieDescriptionPresenterDelegate{

    func popController(){
        self.router.popController()
    }
    
    func getMovieDescription(withMovieId movieId : Int){
        
        guard let viewControllerRef = self.viewController else {return}
        
        self.interactor.getMovieDescription(withMovieId: movieId, onSuccess: { (movieDescription : MovieDescription) in
            viewControllerRef.updateMovieDescription(movieDescription: movieDescription)
        }) { (httpErrorCode) in
            
        }
        
    }
}
