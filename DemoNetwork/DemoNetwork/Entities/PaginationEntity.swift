//
//  PaginationEntity.swift
//  DemoNetwork
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

public class PaginationEntity{
    
    public var currentPage : Int = 0
    public var nextPage : Int = 0
    public var isPaginationAvailable : Bool = false
    init(dictionary : [String : Any]) {
        
        self.currentPage = dictionary["page"] as? Int ?? 0
        let totalPages = dictionary["total_pages"] as? Int ?? 0
        self.nextPage = self.currentPage < totalPages ? (self.currentPage + 1) : self.currentPage
        self.isPaginationAvailable = self.currentPage < totalPages 
    }
    
}
