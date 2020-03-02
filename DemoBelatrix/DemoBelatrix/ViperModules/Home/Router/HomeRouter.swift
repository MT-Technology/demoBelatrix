//
//  HomeRouter.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

protocol HomeRouterDelegate : class{
    
    func goToSearchMovie()
    func goToMovieDescription(movie: Movie)
    
}

class HomeRouter {
    
    private weak var viewController : HomeViewController?
    
    init(viewController : HomeViewController) {
        self.viewController = viewController
    }
}

extension HomeRouter : HomeRouterDelegate{
    
    func goToSearchMovie(){
        guard let currentView = self.viewController,
            let searchController = UIStoryboard(name: "SearchMovie", bundle: nil).instantiateInitialViewController() as? SearchMovieViewController else {
                return
        }
        currentView.navigationController?.pushViewController(searchController, animated: true)
    }
    
    func goToMovieDescription(movie: Movie){
        guard let currentView = self.viewController,
            let descriptionController = UIStoryboard(name: "MovieDescription", bundle: nil).instantiateInitialViewController() as? MovieDescriptionViewController else {
            return
        }
        
        descriptionController.movieDescription = MovieDescription(withMovie: movie)
        currentView.navigationController?.pushViewController(descriptionController, animated: true)
    }
}


