//
//  HomeConfiguration.swift
//  DemoBelatrix
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

protocol HomeViewConfiguratorProtocol {
    func configure(viewController: HomeViewController)
}


class HomeViewConfigurator: HomeViewConfiguratorProtocol {
    
    func configure(viewController: HomeViewController) {
        
        viewController.presenter = HomePresenter(viewController: viewController,
                                                 interactor: HomeInteractor(),
                                                 router: HomeRouter(viewController: viewController))
    }
    
}
