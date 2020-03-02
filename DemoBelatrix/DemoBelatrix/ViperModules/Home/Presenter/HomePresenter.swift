//
//  HomePresenter.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

protocol HomePresenterDelegate : class{
    
    func refreshMovies(withRefresh refresh : UIRefreshControl)
    func getMovies()
    func goToSearchMovie()
    func goToMovieDescription(movie : Movie)
}

class HomePresenter {

    private weak var viewController : HomeViewControllerDelegate?
    private var interactor : HomeInteractorDelegate
    private var router : HomeRouterDelegate
    private var pagination : Pagination
    private var movies : [Movie]
    
    init(viewController : HomeViewControllerDelegate,
         interactor : HomeInteractor,
         router : HomeRouter){
        
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
        self.pagination = Pagination()
        self.movies = []
    }
}
 
extension HomePresenter : HomePresenterDelegate{
    
    func refreshMovies(withRefresh refresh : UIRefreshControl){
        
        guard let viewControllerRef = self.viewController else {return}
        self.pagination = Pagination()
        if pagination.isPaginationAvailable{
            
            refresh.beginRefreshing()
            viewControllerRef.removeNoInternetConnectionView()
            self.interactor.getMovies(withPage: pagination.nextPage, onSuccess: {[weak self] (movies, pagination) in
                guard let welf = self else {
                    refresh.endRefreshing()
                    return
                }
                refresh.endRefreshing()
                viewControllerRef.updateMovies(newMovies: movies)
                welf.pagination = pagination
                
            }) { (httpErrorCode) in
                refresh.endRefreshing()
                switch httpErrorCode{
                case NSURLErrorNotConnectedToInternet:
                    viewControllerRef.showNoInternetConnectionView()
                default: break
                }
            }
        }
    }
    
    func getMovies() {
        
        guard let viewControllerRef = self.viewController else {return}
        
        if pagination.isPaginationAvailable{
            
            
            viewControllerRef.removeNoInternetConnectionView()
            self.interactor.getMovies(withPage: pagination.nextPage, onSuccess: {[weak self] (movies, pagination) in
                guard let welf = self else {
                    return
                }
                if pagination.currentPage == 1{
                    viewControllerRef.updateMovies(newMovies: movies)
                }else{
                    viewControllerRef.insertMoreMovies(newMovies: movies)
                }
                welf.pagination = pagination
                
            }) { (httpErrorCode) in
                
                switch httpErrorCode{
                case NSURLErrorNotConnectedToInternet:
                    viewControllerRef.showNoInternetConnectionView()
                default: break
                }
            }
        }
    }
    
    func goToSearchMovie(){
        self.router.goToSearchMovie()
    }
    
    func goToMovieDescription(movie: Movie) {
        self.router.goToMovieDescription(movie: movie)
    }
}
