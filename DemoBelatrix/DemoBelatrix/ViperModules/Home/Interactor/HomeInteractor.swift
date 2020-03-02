//
//  HomeInteractor.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

protocol HomeInteractorDelegate : class{
    
    func getMovies(withPage page : Int, onSuccess success : @escaping ([Movie],Pagination)->Void, onFailure failure: @escaping (_ httpErrorCode : Int)->Void)
    
}

class HomeInteractor {
    
    private let dataSource : MovieInteractorDelegate
    
    init(){
        self.dataSource = MovieInteractorImplementation()
    }
    
}

extension HomeInteractor : HomeInteractorDelegate{

    func getMovies(withPage page: Int, onSuccess success: @escaping ([Movie], Pagination) -> Void, onFailure failure: @escaping (Int) -> Void) {
        self.dataSource.getPopularMovies(withPage: page, onSuccess: success, onFailure: failure)
    }
}
