//
//  HomeViewController.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

protocol HomeViewControllerDelegate : class{
        
    func insertMoreMovies(newMovies : [Movie])
    func updateMovies(newMovies : [Movie])
    func showNoInternetConnectionView()
    func removeNoInternetConnectionView()
}

class HomeViewController: UIViewController {

    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var searchButton : UIButton!
    @IBOutlet weak var moviesCollectionView : UICollectionView!
    
    private let configurator : HomeViewConfigurator = HomeViewConfigurator()
    private var movieCollectionViewImplementation : MovieCollectionViewImplementation!
    var presenter : HomePresenterDelegate!
    
    lazy var refreshControl : UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "redHeaderColor") 
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var noInternetConnectionView: NoInternetConnectionViewController = { [weak self] in
        let controller = NoInternetConnectionViewController(nibName: "NoInternetConnectionViewController", bundle: nil) as NoInternetConnectionViewController
        
        
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.presenter.getMovies()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func initialSetup(){
        
        self.configurator.configure(viewController: self)
        self.moviesCollectionView.addSubview(self.refreshControl)
        self.movieCollectionViewImplementation = MovieCollectionViewImplementation(collectionView: self.moviesCollectionView)
        self.movieCollectionViewImplementation.delegate = self
    }
        
    @objc private func pullToRefreshAction(){
        self.presenter.refreshMovies(withRefresh: self.refreshControl)
    }
    
    @IBAction func tapSearchButton(_ sender : UIButton){
        self.presenter.goToSearchMovie()
    }
    
    private func showNoInternetView(){
        
        self.noInternetConnectionView.view.frame = self.moviesCollectionView.frame
        self.noInternetConnectionView.view.alpha = 0.0
        self.view.addSubview(self.noInternetConnectionView.view)
        UIView.animate(withDuration: 0.25) {
            self.noInternetConnectionView.view.alpha = 1.0
        }
    }
    
    private func hideNoInternetView(){
        
        if let _ = self.noInternetConnectionView.view.superview {
            
            self.noInternetConnectionView.view.frame = self.moviesCollectionView.frame
            UIView.animate(withDuration: 0.25, animations: {
                self.noInternetConnectionView.view.alpha = 0.0
            }) { (_) in
                self.noInternetConnectionView.view.removeFromSuperview()
            }
        }
    }
}

extension HomeViewController : MovieCollectionViewImplementationDelegate{
    
    func didMovieSelected(movie: Movie) {
        self.presenter.goToMovieDescription(movie: movie)
    }
    
    
    func moviesPagination() {
        self.presenter.getMovies()
    }
}

extension HomeViewController : NoIntertConnectionViewDelegate{
    
    func tryAgainAction() {
        self.presenter.getMovies()
    }
}

extension HomeViewController : HomeViewControllerDelegate{
    
    func showNoInternetConnectionView(){
        self.showNoInternetView()
    }
    
    func removeNoInternetConnectionView(){
        self.hideNoInternetView()
    }
    
    func insertMoreMovies(newMovies : [Movie]){
        self.movieCollectionViewImplementation.insertMoreMovies(newMovies: newMovies)
    }
    
    func updateMovies(newMovies : [Movie]){
        self.movieCollectionViewImplementation.updateMovies(newMovies: newMovies)
    }
}


