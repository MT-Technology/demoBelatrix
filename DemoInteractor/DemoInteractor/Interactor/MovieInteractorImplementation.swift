//
//  InteractorImplementation.swift
//  DemoInteractor
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation
import DemoNetwork

public class MovieInteractorImplementation {
    
    private let networkDataSource : NetworkDataSource
    
    public init(){
        self.networkDataSource = NetworkDataSourceImplementation()
    }
}

extension MovieInteractorImplementation : MovieInteractorDelegate {
    
    public func getPopularMovies(withPage page : Int, onSuccess success : @escaping ([Movie],Pagination)->Void, onFailure failure: @escaping (_ httpErrorCode : Int)->Void){
        
        self.networkDataSource.getPopularMovies(withPage: page, onSuccess: { (response : PopularMovieResponse) in
           
            var movies : [Movie] = []
            for entity in response.getMovies(){
                movies.append(Movie(withMovieEntity: entity))
            }
            success(movies,Pagination(withPaginationEntity: response.getPagination()))
            
        }) { (error : ErrorResponse) in
            failure(error.errorHttpCode)
        }
    }
    
    public func getSearchMovies(withPage page: Int, withQuery query: String, onSuccess success: @escaping ([Movie], Pagination) -> Void, onFailure failure: @escaping (Int) -> Void) {
        
        self.networkDataSource.getSearchMovies(withPage: page, withQuery: query, onSuccess: { (response : SearchMovieResponse) in
            
            var movies : [Movie] = []
            for entity in response.getMovies(){
                movies.append(Movie(withMovieEntity: entity))
            }
            success(movies,Pagination(withPaginationEntity: response.getPagination()))
            
        }) { (error : ErrorResponse) in
            failure(error.errorHttpCode)
        }
    }
    
    public func getMovieDescription(withMovieId movieId : Int, onSuccess success : @escaping (MovieDescription)->Void, onFailure failure : @escaping (_ httpErrorCode : Int) -> Void){
        
        self.networkDataSource.getMovieDescription(withMovieId: movieId, onSuccess: { (response : MovieDescriptionResponse) in
            
            success(MovieDescription(withMovieDescriptionEntity: response.getMovieDescription()))
            
        }) { (error : ErrorResponse) in
            failure(error.errorHttpCode)
        }
        
    }
}
