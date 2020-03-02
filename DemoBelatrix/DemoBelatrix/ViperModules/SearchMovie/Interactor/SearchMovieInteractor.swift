//
//  SearchMovieInteractor.swift
//  DemoBelatrix
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation
import DemoInteractor

protocol SearchMovieInteractorDelegate : class {
    
    func getSearchMovies(withPage page : Int, withQuery query : String, onSuccess success : @escaping ([Movie],Pagination)->Void, onFailure failure: @escaping (_ httpErrorCode : Int)->Void)
}

class SearchMovieInteractor{
    
    private let dataSource : MovieInteractorDelegate
    
    init(){
        self.dataSource = MovieInteractorImplementation()
    }
}

extension SearchMovieInteractor : SearchMovieInteractorDelegate{
    
    func getSearchMovies(withPage page: Int, withQuery query: String, onSuccess success: @escaping ([Movie], Pagination) -> Void, onFailure failure: @escaping (Int) -> Void) {
        self.dataSource.getSearchMovies(withPage: page, withQuery: query, onSuccess: success, onFailure: failure)
    }
}
