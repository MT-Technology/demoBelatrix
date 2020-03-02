//
//  SearchMovieRouter.swift
//  DemoBelatrix
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

protocol SearchMovieRouterDelegate : class{
    
    func goToMovieDescription(movie: Movie)
    func popController()
}

class SearchMovieRouter {
    
    private weak var viewController : SearchMovieViewController?
    
    init(viewController : SearchMovieViewController){
        self.viewController = viewController
    }
}

extension SearchMovieRouter : SearchMovieRouterDelegate{
    
    func goToMovieDescription(movie: Movie){
        
        guard let currentView = self.viewController,
            let descriptionController = UIStoryboard(name: "MovieDescription", bundle: nil).instantiateInitialViewController() as? MovieDescriptionViewController else {
            return
        }
        descriptionController.movieDescription = MovieDescription(withMovie: movie)
        currentView.navigationController?.pushViewController(descriptionController, animated: true)
    }

    func popController(){
        guard let currentView = self.viewController else {return}
        currentView.navigationController?.popViewController(animated: true)
    }
}
