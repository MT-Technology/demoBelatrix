//
//  MovieEntity.swift
//  DemoNetwork
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

public class MovieEntity{
    
    public var popularity       : Double = 0.0
    public var votes            : Int    = 0
    public var posterImageUrl   : String = ""
    public var backdropImgeUrl  : String = ""
    public var movieId          : Int    = 0
    public var title            : String = ""
    public var average          : Double = 0.0
    public var movieDescription : String = ""
    public var releaseDate      : String = ""
    
    init(dictionary : [String:Any]) {
        
        let networkUrlDataSource = NetworkUrlDataSource()
        
        self.popularity       = dictionary["popularity"] as? Double ?? 0.0
        self.votes            = dictionary["vote_count"] as? Int ?? 0
        self.posterImageUrl   = networkUrlDataSource.posterImageUrl(withPosterId: dictionary["poster_path"] as? String ?? "")
        self.backdropImgeUrl  = networkUrlDataSource.backdropImageUrl(withBackdropId: dictionary["backdrop_path"] as? String ?? "")
        self.movieId          = dictionary["id"] as? Int ?? 0
        self.title            = dictionary["title"] as? String ?? ""
        self.average          = dictionary["vote_average"] as? Double ?? 0.0
        self.movieDescription = dictionary["overview"] as? String ?? ""
        self.releaseDate      = dictionary["release_date"] as? String ?? ""
        
    }
}
