//
//  SearchMoviePresenter.swift
//  DemoBelatrix
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

protocol SearchMoviePresenterDelegate : class{
    
    func refreshMovies(withRefresh refresh : UIRefreshControl)
    func set(searchText : String)
    func getMovies()
    func goToMovieDescription(movie: Movie)
    func popController()
}

class SearchMoviePresenter {
    
    private weak var viewController : SearchMovieViewControllerDelegate?
    private var interactor : SearchMovieInteractorDelegate
    private var router : SearchMovieRouterDelegate
    private var pagination : Pagination
    private var movies : [Movie]
    private var searchText : String
    
    init(viewController : SearchMovieViewControllerDelegate,
         interactor : SearchMovieInteractor,
         router : SearchMovieRouter){
        
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
        self.pagination = Pagination()
        self.movies = []
        self.searchText = ""
    }
}

extension SearchMoviePresenter : SearchMoviePresenterDelegate{
    func refreshMovies(withRefresh refresh: UIRefreshControl) {
        
        guard let viewControllerRef = self.viewController,
            self.searchText.isEmpty == false else{
                return
        }
        
        self.pagination = Pagination()
        
        if self.pagination.isPaginationAvailable{
            
            refresh.beginRefreshing()
            self.interactor.getSearchMovies(withPage: pagination.nextPage, withQuery: self.searchText, onSuccess: {[weak self] (movies, pagination) in
                guard let welf = self else{
                    refresh.endRefreshing()
                    return
                }
                refresh.endRefreshing()
                viewControllerRef.updateMovies(newMovies: movies)
                welf.pagination = pagination
            }) { (httpErrorCode) in
                refresh.endRefreshing()
            }
        }
        
    }
    
    func getMovies() {
        
        guard let viewControllerRef = self.viewController else {return}
        
    
        if self.searchText.isEmpty{
            viewControllerRef.clearMovies()
            return
        }
        
        if pagination.isPaginationAvailable{
            
            self.interactor.getSearchMovies(withPage: pagination.nextPage, withQuery: self.searchText, onSuccess: {[weak self] (movies, pagination) in
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
            }
        }
        
    }
    
    func set(searchText : String){
        self.searchText = searchText
        self.pagination = Pagination()
    }
    
    func goToMovieDescription(movie: Movie){
        self.router.goToMovieDescription(movie: movie)
    }
    
    func popController(){
        self.router.popController()
    }
}
