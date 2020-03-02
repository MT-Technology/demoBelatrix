//
//  File.swift
//  DemoNetwork
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

public class PopularMovieResponse{
    
    private var movies : [MovieEntity]
    private var pagination : PaginationEntity
    
    init(dictionary : [String:Any]) {
        
        self.pagination = PaginationEntity(dictionary: dictionary)
        self.movies = []
        if let moviesUnParsed = dictionary["results"] as? [[String:Any]]{
            for movieUnParsed in moviesUnParsed{
                movies.append(MovieEntity(dictionary: movieUnParsed))
            }
        }
    }
    
    public func getMovies()->[MovieEntity]{
        return self.movies
    }
    
    public func getPagination()->PaginationEntity{
        return self.pagination
    }
}
