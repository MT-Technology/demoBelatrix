//
//  Movie.swift
//  DemoInteractor
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation
import DemoNetwork

public class Movie{
    
    public var popularity       : Double = 0.0
    public var votes            : Int    = 0
    public var posterImageUrl   : String = ""
    public var backdropImgeUrl  : String = ""
    public var movieId          : Int    = 0
    public var title            : String = ""
    public var average          : Double = 0.0
    public var movieDescription : String = ""
    public var releaseDate      : String = ""
    
    public init (){}
    
    public init(withMovieEntity entity : MovieEntity){
        
        self.popularity = entity.popularity
        self.votes = entity.votes
        self.posterImageUrl = entity.posterImageUrl
        self.backdropImgeUrl = entity.backdropImgeUrl
        self.movieId = entity.movieId
        self.title = entity.title
        self.average = entity.average
        self.movieDescription = entity.movieDescription
        self.releaseDate = entity.releaseDate
    }
    
}
