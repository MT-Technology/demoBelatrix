//
//  SearchMovieViewController.swift
//  DemoBelatrix
//
//  Created by everis on 2/29/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit
import DemoInteractor

protocol SearchMovieViewControllerDelegate : class{
    
    func updatePagination(newPagination : Pagination)
    func insertMoreMovies(newMovies : [Movie])
    func updateMovies(newMovies : [Movie])
    func clearMovies()
}

class SearchMovieViewController: UIViewController {

    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var headerView : UIView!
    @IBOutlet weak var snapshotView : UIView!
    @IBOutlet weak var blurView : UIView!
    @IBOutlet weak var leftSearchBarConstraint : NSLayoutConstraint!
    @IBOutlet weak var rightSearchBarConstraint : NSLayoutConstraint!
    @IBOutlet weak var moviesCollectionView : UICollectionView!
    
    lazy var refreshControl : UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "redHeaderColor")
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    private let configurator : SearchMovieConfigurator = SearchMovieConfigurator()
    private var movieCollectionViewImplementation : MovieCollectionViewImplementation!
    var presenter : SearchMoviePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    private func initialSetup(){
        self.configurator.configure(viewController: self)
        self.setupSearchBar()
        self.moviesCollectionView.addSubview(self.refreshControl)
        self.movieCollectionViewImplementation = MovieCollectionViewImplementation(collectionView: self.moviesCollectionView)
        self.movieCollectionViewImplementation.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func pullToRefreshAction(){
        self.presenter.refreshMovies(withRefresh: self.refreshControl)
    }
    
    private func setupSearchBar(){

        self.searchBar.searchBarStyle = .minimal
        self.searchBar.searchTextField.backgroundColor = UIColor(named: "redHeaderColor")
        self.searchBar.searchTextField.textColor = .white
        self.searchBar.searchTextField.clearButtonMode = .never
        let leftImage = self.searchBar.searchTextField.leftView as? UIImageView
        leftImage?.tintColor = .white
    }
    
    @IBAction private func back(_ sender : UIButton){
        self.presenter.popController()
    }
}

extension SearchMovieViewController : UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchBar.text = ""
        self.presenter.set(searchText: "")
        self.presenter.getMovies()
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            self.view.endEditing(true)
            return
        }
        self.presenter.set(searchText: searchText)
        self.presenter.getMovies()
        self.view.endEditing(true)
    }
}

extension SearchMovieViewController : MovieCollectionViewImplementationDelegate{
     
    func didMovieSelected(movie: Movie) {
        self.presenter.goToMovieDescription(movie: movie)
    }
    
    func moviesPagination() {
        self.presenter.getMovies()
    }
}

extension SearchMovieViewController : SearchMovieViewControllerDelegate{
    
    func updatePagination(newPagination : Pagination){
        self.movieCollectionViewImplementation.updatePagination(newPagination: newPagination)
    }
    
    func insertMoreMovies(newMovies : [Movie]){
        self.movieCollectionViewImplementation.insertMoreMovies(newMovies: newMovies)
    }
    
    func updateMovies(newMovies : [Movie]){
        self.movieCollectionViewImplementation.updateMovies(newMovies: newMovies)
    }
    
    func clearMovies(){
        self.movieCollectionViewImplementation.clearMovies()
    }
}
