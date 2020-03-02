//
//  File.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

public protocol NetworkDataSource {
    
    func getPopularMovies(withPage page : Int, onSuccess success : @escaping (PopularMovieResponse)->Void, onFailure failure: @escaping (ErrorResponse)->Void)
    
    func getSearchMovies(withPage page : Int, withQuery query : String, onSuccess success : @escaping (SearchMovieResponse)->Void, onFailure failure: @escaping (ErrorResponse)->Void)
    
    func getMovieDescription(withMovieId movieId : Int, onSuccess success : @escaping (MovieDescriptionResponse)->Void, onFailure failure : @escaping (ErrorResponse) -> Void)
}
