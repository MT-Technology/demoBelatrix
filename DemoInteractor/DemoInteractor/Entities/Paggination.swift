//
//  Paggination.swift
//  DemoInteractor
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation
import DemoNetwork

public class Pagination{
    
    public var currentPage           : Int  = 0
    public var nextPage              : Int  = 1
    public var isPaginationAvailable : Bool = true
    
    public init() {}
    public init(withPaginationEntity entity : PaginationEntity) {
        
        self.currentPage = entity.currentPage
        self.nextPage = entity.nextPage
        self.isPaginationAvailable = entity.isPaginationAvailable
    }
}


