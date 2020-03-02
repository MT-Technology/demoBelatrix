//
//  MovieDescription.swift
//  DemoInteractor
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation
import DemoNetwork

public class MovieDescription{
    
    public var popularity       : Double   = 0.0
    public var votes            : Int      = 0
    public var posterImageUrl   : String   = ""
    public var backdropImgeUrl  : String   = ""
    public var movieId          : Int      = 0
    public var title            : String   = ""
    public var average          : Double   = 0.0
    public var movieDescription : String   = ""
    public var releaseDate      : String   = ""
    
    public var budget           : Int      = 0
    public var webSiteUrl       : String   = ""
    public var revenue          : Int      = 0
    public var runtime          : Int      = 0
    public var genres           : [String] = []
    
    public init(){}
    
    public init(withMovie movie : Movie){
        
        self.popularity = movie.popularity
        self.votes = movie.votes
        self.posterImageUrl = movie.posterImageUrl
        self.backdropImgeUrl = movie.backdropImgeUrl
        self.movieId = movie.movieId
        self.title = movie.title
        self.average = movie.average
        self.movieDescription = movie.movieDescription
        self.releaseDate = movie.releaseDate
    }
    
    public init(withMovieDescriptionEntity entity : MovieDescriptionEntity){
        
        self.popularity = entity.popularity
        self.votes = entity.votes
        self.posterImageUrl = entity.posterImageUrl
        self.backdropImgeUrl = entity.backdropImgeUrl
        self.movieId = entity.movieId
        self.title = entity.title
        self.average = entity.average
        self.movieDescription = entity.movieDescription
        self.releaseDate = entity.releaseDate
        self.budget = entity.budget
        self.webSiteUrl = entity.webSiteUrl
        self.revenue = entity.revenue
        self.runtime = entity.runtime
        self.genres = entity.genres
    }
    
    public func getGenres() -> String{
        
        var genresText = ""
        for genre in self.genres{
            
            genresText.append("- \(genre)\n")
        }
        
        return genresText
    }
    
    public func getBudget() -> String{
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current

        return currencyFormatter.string(from: NSNumber(value: self.budget)) ?? ""
    }
    
    public func getRevenue() -> String{
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current

        return currencyFormatter.string(from: NSNumber(value: self.revenue)) ?? ""
    }
}
