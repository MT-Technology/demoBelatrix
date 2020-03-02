//
//  MovieDescriptionConfiguration.swift
//  DemoBelatrix
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

protocol MovieDescriptionConfiguratorProtocol {
    
    func configure(viewController : MovieDescriptionViewController)
}

class MovieDescriptionConfigurator : MovieDescriptionConfiguratorProtocol{
    
    func configure(viewController: MovieDescriptionViewController) {
        viewController.presenter = MovieDescriptionPresenter(viewController: viewController,
                                                             interactor: MovieDescriptionInteractor(),
                                                             router: MovieDescriptionRouter(viewController: viewController))
    }
}
