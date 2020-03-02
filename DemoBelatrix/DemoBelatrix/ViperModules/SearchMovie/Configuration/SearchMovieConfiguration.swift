//
//  SearchMovieConfiguration.swift
//  DemoBelatrix
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation


protocol SearchMovieViewConfiguratorProtocol {
    func configure(viewController: SearchMovieViewController)
}


class SearchMovieConfigurator: SearchMovieViewConfiguratorProtocol {
    
    func configure(viewController: SearchMovieViewController) {
        
        viewController.presenter = SearchMoviePresenter(viewController: viewController,
                                                        interactor: SearchMovieInteractor(),
                                                        router: SearchMovieRouter(viewController: viewController))
    }
    
}
