//
//  ErrorResponse.swift
//  DemoNetwork
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import Foundation

public class ErrorResponse {
    
    public var errorHttpCode : Int = 404
    
    init(errorHttpCode : Int) {
        self.errorHttpCode = errorHttpCode
    }
    
}
