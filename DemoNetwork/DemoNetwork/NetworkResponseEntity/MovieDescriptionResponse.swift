//
//  MovieDescriptionResponse.swift
//  DemoNetwork
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

public class MovieDescriptionResponse{
    
    private var movieDescription : MovieDescriptionEntity
    
    init(dictionary : [String:Any]) {
        
        self.movieDescription = MovieDescriptionEntity(dictionary: dictionary)
    }
    
    public func getMovieDescription() -> MovieDescriptionEntity{
        return self.movieDescription
    }   
}
