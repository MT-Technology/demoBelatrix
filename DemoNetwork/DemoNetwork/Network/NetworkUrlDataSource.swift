//
//  NetworkUrlDataSource.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

class NetworkUrlDataSource {
    
    private let networkProperties : NetworkProperties
    private let language : String
    
    init() {
        
        self.networkProperties = NetworkProperties()
        self.language = Locale.current.languageCode ?? ""
    }
    
    
    func posterImageUrl(withPosterId posterId : String) -> String{
        return "\(networkProperties.getApiImagePosterUrl())\(posterId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    func backdropImageUrl(withBackdropId backdropId : String) -> String{
        return "\(networkProperties.getApiImageBackdropUrl())\(backdropId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    func popularMovieUrl(withPage page : Int) -> String {
        return "\(networkProperties.getApiUrl())/3/movie/popular?api_key=\(networkProperties.getApiKey())&language=\(language)&page=\(page)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    func searchMovieUrl(withPage page : Int, withQuery query : String) -> String{
        return "\(networkProperties.getApiUrl())/3/search/movie?api_key=\(networkProperties.getApiKey())&language=\(language)&page=\(page)&query=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    func movieDescriptionUrl(withMovieId movieId : Int) -> String{
        return "\(networkProperties.getApiUrl())/3/movie/\(movieId)?api_key=\(networkProperties.getApiKey())&language=\(language)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

    }
}
