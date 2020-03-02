//
//  MovieDescriptionInteractor.swift
//  DemoBelatrix
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation
import DemoInteractor

protocol MovieDescriptionInteractorDelegate : class{

    func getMovieDescription(withMovieId movieId : Int, onSuccess success : @escaping (MovieDescription)->Void, onFailure failure : @escaping (_ httpErrorCode : Int) -> Void)
}

class MovieDescriptionInteractor{
    
    private let dataSource : MovieInteractorDelegate
    
    init(){
        self.dataSource = MovieInteractorImplementation()
    }
}

extension MovieDescriptionInteractor : MovieDescriptionInteractorDelegate{
    
    func getMovieDescription(withMovieId movieId: Int, onSuccess success: @escaping (MovieDescription) -> Void, onFailure failure: @escaping (Int) -> Void) {
        self.dataSource.getMovieDescription(withMovieId: movieId, onSuccess: success, onFailure: failure)
    }
}
