//
//  MovieDescriptionViewController.swift
//  DemoBelatrix
//
//  Created by everis on 3/1/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

protocol MovieDescriptionViewControllerDelegate : class{
    
    func updateMovieDescription(movieDescription : MovieDescription)
}

class MovieDescriptionViewController: UIViewController {

    @IBOutlet weak var headerView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var scrollViewDescription : UIScrollView!
    @IBOutlet weak var backdropImageView : UIImageView!
    @IBOutlet weak var posterImageView : UIImageView!
    @IBOutlet weak var movieTitleLabel : UILabel!
    @IBOutlet weak var movieDescriptionLabel : UILabel!
    @IBOutlet weak var movieDurationLabel : UILabel!
    @IBOutlet weak var movieRatedLabel : UILabel!
    @IBOutlet weak var movieGenresLabel : UILabel!
    @IBOutlet weak var movieReleaseDateLabel : UILabel!
    @IBOutlet weak var movieRevenueLabel : UILabel!
    @IBOutlet weak var movieBudgetLabel : UILabel!
    @IBOutlet weak var movieWebLabel : UILabel!
    
    @IBOutlet var widthPosterImageViewConstraint : NSLayoutConstraint!
    @IBOutlet var spaceTopPosterImageViewConstraint : NSLayoutConstraint!
    
    @IBOutlet var topBackdropImageViewConstraint : NSLayoutConstraint!
    @IBOutlet var heightBackdropImageViewContraint : NSLayoutConstraint!
    
    private let configurator : MovieDescriptionConfigurator = MovieDescriptionConfigurator()
    private var initialHeightImageContraint : CGFloat = 0.0
    
    var presenter : MovieDescriptionPresenterDelegate!
    var movieDescription : MovieDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func initialSetup(){
        self.configurator.configure(viewController: self)
        self.posterImageView.layer.borderWidth = 3
        self.posterImageView.layer.borderColor = UIColor(named: "redHeaderColor")?.cgColor
        
        self.heightBackdropImageViewContraint.constant = (UIScreen.main.bounds.width/320)*180
        self.widthPosterImageViewConstraint.constant = (UIScreen.main.bounds.width/3)
        self.view.layoutIfNeeded()
        self.spaceTopPosterImageViewConstraint.constant = self.posterImageView.frame.height * 0.4
        self.view.layoutIfNeeded()
        self.initialHeightImageContraint = self.heightBackdropImageViewContraint.constant
        self.displayInfo()
        self.presenter.getMovieDescription(withMovieId: movieDescription?.movieId ?? 0)
        
    }
    
    private func displayInfo(){
        
        if let urlString = movieDescription?.backdropImgeUrl,
            let url = URL(string: urlString){
            MTImageDownloadManager.downloadImage(url: url, success: { [weak self] (image) in
                guard let welf = self else {return}
                UIView.transition(with: welf.backdropImageView, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    welf.backdropImageView.image = image
                }, completion: nil)
            }, failure: nil)
        }
        
        if let urlString = movieDescription?.posterImageUrl,
            let url = URL(string: urlString){
            MTImageDownloadManager.downloadImage(url: url, success: { [weak self] (image) in
                guard let welf = self else {return}
                UIView.transition(with: welf.posterImageView, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    welf.posterImageView.image = image
                }, completion: nil)
            }) { [weak self] in
                guard let welf = self else {return}
                UIView.transition(with: welf.posterImageView, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    welf.posterImageView.image = UIImage(named: "posterPlaceholder")
                }, completion: nil)
            }
        }
        
        
        self.setTextAnimatedInLabel(labelAnimated: self.movieTitleLabel, textLabel: self.movieDescription?.title ?? "")
        self.setTextAnimatedInLabel(labelAnimated: self.movieDescriptionLabel, textLabel: self.movieDescription?.movieDescription ?? "")
        self.setTextAnimatedInLabel(labelAnimated: self.movieDurationLabel, textLabel: "\(self.movieDescription?.runtime ?? 0) min")
        self.setTextAnimatedInLabel(labelAnimated: self.movieRatedLabel, textLabel: "\(self.movieDescription?.average ?? 0.0)/10")
        self.setTextAnimatedInLabel(labelAnimated: self.movieGenresLabel, textLabel: self.movieDescription?.getGenres() ?? "")
        self.setTextAnimatedInLabel(labelAnimated: self.movieReleaseDateLabel, textLabel: self.movieDescription?.releaseDate ?? "")
        self.setTextAnimatedInLabel(labelAnimated: self.movieRevenueLabel, textLabel: "\(self.movieDescription?.getRevenue() ?? "") USD")
        self.setTextAnimatedInLabel(labelAnimated: self.movieBudgetLabel, textLabel: "\(self.movieDescription?.getBudget() ?? "") USD")
        self.setTextAnimatedInLabel(labelAnimated: self.movieWebLabel, textLabel: self.movieDescription?.webSiteUrl ?? "")
    }
    
    private func setTextAnimatedInLabel(labelAnimated : UILabel, textLabel : String){
        UIView.transition(with: labelAnimated, duration: 0.25, options: .transitionCrossDissolve, animations: {
            labelAnimated.text = textLabel
        }, completion: nil)
    }
    
    @IBAction private func back (_ sender : UIButton){
        self.presenter.popController()
    }
    
    @IBAction private func openUrl (_ sender : UIButton){
        
        if let urlString = self.movieDescription?.webSiteUrl,
            let url = URL(string: urlString){
            UIApplication.shared.open(url)
        }
        
    }
}

extension MovieDescriptionViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        print(scrollView.contentOffset.y)
        self.topBackdropImageViewConstraint.constant   = scrollView.contentOffset.y <= 0 ? scrollView.contentOffset.y : 0
        self.heightBackdropImageViewContraint.constant = self.initialHeightImageContraint + (scrollView.contentOffset.y <= 0 ? -scrollView.contentOffset.y : 0)
    }
}

extension MovieDescriptionViewController : MovieDescriptionViewControllerDelegate{
    
    func updateMovieDescription(movieDescription : MovieDescription){
        self.movieDescription = movieDescription
        self.displayInfo()
    }
}
