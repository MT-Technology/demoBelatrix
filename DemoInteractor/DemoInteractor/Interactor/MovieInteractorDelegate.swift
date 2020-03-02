//
//  InteractorDelegate.swift
//  DemoInteractor
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation


public protocol MovieInteractorDelegate{
    
    func getPopularMovies(withPage page : Int, onSuccess success : @escaping ([Movie],Pagination)->Void, onFailure failure: @escaping (_ httpErrorCode : Int)->Void)
    
    
    func getSearchMovies(withPage page : Int, withQuery query : String, onSuccess success : @escaping ([Movie],Pagination)->Void, onFailure failure: @escaping (_ httpErrorCode : Int)->Void)
    
    func getMovieDescription(withMovieId movieId : Int, onSuccess success : @escaping (MovieDescription)->Void, onFailure failure : @escaping (_ httpErrorCode : Int) -> Void)
    
}
