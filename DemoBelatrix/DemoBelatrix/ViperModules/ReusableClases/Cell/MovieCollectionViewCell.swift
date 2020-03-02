//
//  MovieCollectionViewCell.swift
//  DemoBelatrix
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView : UIImageView!
    @IBOutlet weak var movieTitleLabel : UILabel!
    
    private var downloadTask : URLSessionTask?
    
    override func prepareForReuse() {
        movieImageView.image = nil
        movieTitleLabel.text = ""
        
        if downloadTask?.state == .running ||
            downloadTask?.state == .suspended{
            downloadTask?.cancel()
            downloadTask = nil
        }
        
    }
    
    func displayInfo(movie : Movie){
        
        self.setTextAnimatedInLabel(labelAnimated: self.movieTitleLabel, textLabel: movie.title)
        
        if let url = URL(string: movie.posterImageUrl){
            self.downloadTask = MTImageDownloadManager.downloadImage(url: url, success: {[weak self] (image) in
                guard let welf = self else {return}
                UIView.transition(with: welf.movieImageView, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    welf.movieImageView.image = image
                    welf.movieTitleLabel.text = ""
                }, completion: nil)

            }, failure: { [weak self] in
                guard let welf = self else {return}
                UIView.transition(with: welf.movieImageView, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    welf.movieImageView.image = UIImage(named: "posterPlaceholder")
                }, completion: nil)
            })
        }
        
    }
    
    func setTextAnimatedInLabel(labelAnimated : UILabel, textLabel : String){
        UIView.transition(with: labelAnimated, duration: 0.25, options: .transitionCrossDissolve, animations: {
            labelAnimated.text = textLabel
        }, completion: nil)
    }
}
