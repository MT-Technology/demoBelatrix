//
//  MovieCollectionViewImplementation.swift
//  DemoBelatrix
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

protocol MovieCollectionViewImplementationDelegate : class{
    
    func moviesPagination()
    
    func didMovieSelected(movie : Movie)
}

class MovieCollectionViewImplementation : NSObject {
    
    private var movieCollectionView : UICollectionView
    private var movies : [Movie] = []
    
    weak var delegate : MovieCollectionViewImplementationDelegate?
    
    init(collectionView : UICollectionView){
        self.movieCollectionView = collectionView
        super.init()
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
        
        self.movieCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        self.movieCollectionView.register(UINib(nibName: "MovieFooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MovieFooterCollectionReusableView")
    }
    
    func insertMoreMovies(newMovies : [Movie]){
        
        let currentSize = self.movies.count
        self.movies.append(contentsOf: newMovies)
        var arrayIndexPath = [IndexPath]()
        for index in currentSize..<self.movies.count{
            arrayIndexPath.append(IndexPath(row: index, section: 0))
        }
        self.movieCollectionView.insertItems(at: arrayIndexPath)
    }
    
    func updateMovies(newMovies : [Movie]){
        self.movies = newMovies
        self.movieCollectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func clearMovies(){
        self.movies.removeAll()
        self.movieCollectionView.reloadSections(IndexSet(integer: 0))
    }
    
}

extension MovieCollectionViewImplementation : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath){
        
        if self.movies.count != 0{
            self.delegate?.moviesPagination()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.didMovieSelected(movie: self.movies[indexPath.row])
    }
}

extension MovieCollectionViewImplementation : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.displayInfo(movie: self.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieFooterCollectionReusableView", for: indexPath) as! MovieFooterCollectionReusableView
             
            return footer
        }
        return UICollectionReusableView()
    }
}

extension MovieCollectionViewImplementation : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
     
        let multiplier = (UIScreen.main.bounds.width/3.0)/(320.0/3.0)
        return CGSize(width: 106.0 * multiplier, height: 159.0 * multiplier)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        
        if self.movies.count != 0{
            return CGSize(width: UIScreen.main.bounds.width, height: 60.0)
        }else{
            return CGSize.zero
        }
    }
}
