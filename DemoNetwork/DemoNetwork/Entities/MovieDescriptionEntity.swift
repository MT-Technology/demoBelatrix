//
//  MovieDescriptionEntity.swift
//  DemoNetwork
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

public class MovieDescriptionEntity{
    
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
        
        self.budget           = dictionary["budget"] as? Int ?? 0
        self.webSiteUrl       = dictionary["homepage"] as? String ?? ""
        self.revenue          = dictionary["revenue"] as? Int ?? 0
        self.runtime          = dictionary["runtime"] as? Int ?? 0
        if let genres = dictionary["genres"] as? [[String:Any]]{
            for genre in genres{
                self.genres.append(genre["name"] as? String ?? "")
            }
        }
        
//        "genres": [
//            {
//                "id": 28,
//                "name": "Acción"
//            },
//            {
//                "id": 80,
//                "name": "Crimen"
//            },
//            {
//                "id": 35,
//                "name": "Comedia"
//            }
//        ],
//        "imdb_id": "tt7713068",
//        "original_language": "en",
//        "original_title": "Birds of Prey (and the Fantabulous Emancipation of One Harley Quinn)",
//        "production_companies": [
//            {
//                "id": 9993,
//                "logo_path": "/2Tc1P3Ac8M479naPp1kYT3izLS5.png",
//                "name": "DC Entertainment",
//                "origin_country": "US"
//            },
//            {
//                "id": 82968,
//                "logo_path": null,
//                "name": "LuckyChap Entertainment",
//                "origin_country": "GB"
//            },
//            {
//                "id": 103462,
//                "logo_path": null,
//                "name": "Kroll & Co Entertainment",
//                "origin_country": "US"
//            },
//            {
//                "id": 174,
//                "logo_path": "/IuAlhI9eVC9Z8UQWOIDdWRKSEJ.png",
//                "name": "Warner Bros. Pictures",
//                "origin_country": "US"
//            },
//            {
//                "id": 429,
//                "logo_path": "/2Tc1P3Ac8M479naPp1kYT3izLS5.png",
//                "name": "DC Comics",
//                "origin_country": "US"
//            },
//            {
//                "id": 128064,
//                "logo_path": null,
//                "name": "DC Films",
//                "origin_country": "US"
//            },
//            {
//                "id": 101831,
//                "logo_path": "/l6x0SkRVp9ksGgRhboZbkI9w7PM.png",
//                "name": "Clubhouse Pictures",
//                "origin_country": "US"
//            }
//        ],
//        "production_countries": [
//            {
//                "iso_3166_1": "US",
//                "name": "United States of America"
//            }
//        ]
//        "spoken_languages": [
//            {
//                "iso_639_1": "en",
//                "name": "English"
//            }
//        ]
    }
}
