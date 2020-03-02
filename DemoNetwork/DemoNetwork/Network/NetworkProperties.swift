//
//  NetworkProperties.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

class NetworkProperties{
    
    private var propertiesDictionary : NSDictionary?
    
    public init(){
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "Info", ofType: "plist"),
                let rootDictionary = NSDictionary(contentsOfFile: path),
                let properties = rootDictionary["Network"] as? NSDictionary else{
            return
        }
        self.propertiesDictionary = properties
    }
    
    
    
    func getApiKey() -> String{
        guard let properties = propertiesDictionary else {return ""}
        return properties["API_KEY"] as? String ?? ""
    }
    
    func getApiUrl() -> String{
        guard let properties = propertiesDictionary else {return ""}
        return properties["API_URL"] as? String ?? ""
    }
    
    func getApiImagePosterUrl() -> String{
        guard let properties = propertiesDictionary else {return ""}
        return properties["API_POSTER_URL"] as? String ?? ""
    }
    
    func getApiImageBackdropUrl() -> String{
        guard let properties = propertiesDictionary else {return ""}
        return properties["API_BACKDROP_URL"] as? String ?? ""
    }
}
