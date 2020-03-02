//
//  NetworkDataSourceImplementation.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation


public class NetworkDataSourceImplementation {
    
    private let networkUrl : NetworkUrlDataSource
    
    public init(){
        self.networkUrl = NetworkUrlDataSource()
    }
    
}

extension NetworkDataSourceImplementation : NetworkDataSource{
    
    public func getPopularMovies(withPage page: Int, onSuccess success: @escaping (PopularMovieResponse) -> Void, onFailure failure: @escaping (ErrorResponse)->Void) {
        
        let urlString = self.networkUrl.popularMovieUrl(withPage: page)
        
        MTWebServiceManager.shared.request.getRequest(urlString: urlString, parameters: nil) { (webServiceResponse : MTWebServiceResponse) in
            
            if webServiceResponse.status == .success{
                
                if let response = webServiceResponse.response as? [String:Any]{
                    success(PopularMovieResponse(dictionary: response))
                }
            }else{
                failure(ErrorResponse(errorHttpCode: webServiceResponse.httpCode))
            }
        }
    }
    
    public func getSearchMovies(withPage page : Int, withQuery query : String, onSuccess success : @escaping (SearchMovieResponse)->Void, onFailure failure: @escaping (ErrorResponse)->Void){
        
        let urlString = self.networkUrl.searchMovieUrl(withPage: page, withQuery: query)
        
        MTWebServiceManager.shared.request.getRequest(urlString: urlString, parameters: nil) { (webServiceResponse : MTWebServiceResponse) in
            
            if webServiceResponse.status == .success{
                
                if let response = webServiceResponse.response as? [String:Any]{
                    success(SearchMovieResponse(dictionary: response))
                }
            }else{
                failure(ErrorResponse(errorHttpCode: webServiceResponse.httpCode))
            }
        }
    }
    
    public func getMovieDescription(withMovieId movieId : Int, onSuccess success : @escaping (MovieDescriptionResponse)->Void, onFailure failure : @escaping (ErrorResponse) -> Void){
        
        let urlString = self.networkUrl.movieDescriptionUrl(withMovieId: movieId)
        
        MTWebServiceManager.shared.request.getRequest(urlString: urlString, parameters: nil) { (webServiceResponse : MTWebServiceResponse) in
            
            if webServiceResponse.status == .success{
                
                if let response = webServiceResponse.response as? [String:Any]{
                    success(MovieDescriptionResponse(dictionary: response))
                }
            }else{
                failure(ErrorResponse(errorHttpCode: webServiceResponse.httpCode))
            }
        }
    }
}
