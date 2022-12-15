//
//  ListMoviesViewController.swift
//  Cinematic
//
//  Created by Gurpreet Kaur on 2022-12-15.
//

import UIKit

class ListMoviesViewController: UIViewController ,MoviesViewInteractionLogic {
    private var viewModel = ListMoviesViewModel()
    
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = viewModel.viewTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = viewModel.viewTitle
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSarchController()
        fetchMovies()
    }
    
    // MARK: - Setup
    private func setup() {
        moviesView.viewController = self
        
        
        
    }
    private func setupSarchController() {
        let searchMoviesViewController = SearchMoviesViewController(sender: self)
        searchMoviesViewController.view.layoutIfNeeded()
        let searchController = UISearchController(searchResultsController: searchMoviesViewController)
        searchController.searchResultsUpdater = searchMoviesViewController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Nome do filme"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    unc fetchMovies(nextPage: Bool = false) {
        viewModel.fetchPopularMovies(nextPage: nextPage) { (movieViewModel) in
            DispatchQueue.main.async {
                self.moviesView.movies = movieViewModel.movies ?? []
                self.moviesView.collectionView.reloadData()
            }
        }
    }

    func fetchGenres() {
        viewModel.fetchGenres { (genres) in
            DispatchQueue.main.async {
                // TODO: mostrar filtro de categoria
            }
        }
    }
}
