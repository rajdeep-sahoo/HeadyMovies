//
//  MoviesViewModel.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 25/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

// MARK: - Local Methods
extension MoviesViewController {
    
    func setupViews() {
        self.noMoviesFoundLbl.textColor = UIColor(rgb: TEXT_BLACK_COLOR)
        setupCollectionView()
        getPopularMovies(shouldScrollToTop: false)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        self.navigationItem.title = DISCOVER_MOVIES
        
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBtnTapped))
        searchBtn.tintColor = .black

        sortBtn.setImage(UIImage(named: "sort_icon"), for: .normal)
        sortBtn.contentMode = .scaleAspectFit
        sortBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        sortBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        sortBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sortBtn.addTarget(self, action: #selector(sortBtnTapped), for: .touchUpInside)
        
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = searchBtn
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: sortBtn)
    }
    
    func setupCollectionView() {
        collectionView?.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseId)
        collectionView?.backgroundColor = UIColor(rgb: BACKGROUND_COLOR)
    }
    
    func refreshCollectionView(shouldScrollToTop: Bool) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            if shouldScrollToTop {
                if self.movies.count > 0 {
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                    self.noMoviesFoundLbl(show: false)
                } else {
                    self.noMoviesFoundLbl(show: true)
                }
            }
        }
    }
    
    func noMoviesFoundLbl(show: Bool) {
        DispatchQueue.main.async {
            if show {
                self.noMoviesFoundLbl.isHidden = false
                self.noMoviesFoundLbl.text = NO_MOVIES_FOUND
            } else {
                self.noMoviesFoundLbl.isHidden = true
            }
        }
    }
    
    func getPopularMovies(page: Int = 1, shouldScrollToTop: Bool, showLoader: Bool = true) {
        let url = "/movie/popular?api_key=\(TMDB_API_KEY)&language=en-US&page=\(page)"
        APIManager.shared.getRequest(url: url, viewController: self, showLoader: showLoader, for: Movies.self, success: { (response) in
            
            self.movies += response.results
            self.page = response.page
            self.totalPages = response.total_pages
            
            self.refreshCollectionView(shouldScrollToTop: shouldScrollToTop)
        }) { (error) in
            self.movies.removeAll()
            self.noMoviesFoundLbl(show: true)
            Utility.shared.showAlert(withMessage: error, from: self)
        }
    }
    
    func getHighestRatedMovies(page: Int = 1, shouldScrollToTop: Bool, showLoader: Bool = true) {
        let url = "/movie/top_rated?api_key=\(TMDB_API_KEY)&language=en-US&page=\(page)"
        APIManager.shared.getRequest(url: url, viewController: self, showLoader: showLoader, for: Movies.self, success: { (response) in
            
            self.movies += response.results
            self.page = response.page
            self.totalPages = response.total_pages
            
            self.refreshCollectionView(shouldScrollToTop: shouldScrollToTop)
        }) { (error) in
            self.movies.removeAll()
            self.noMoviesFoundLbl(show: true)
            Utility.shared.showAlert(withMessage: error, from: self)
        }
    }
    
    func searchMovie(page: Int = 1, movieName: String, shouldScrollToTop: Bool, showLoader: Bool = true) {
        let url = "/search/movie?api_key=\(TMDB_API_KEY)&query=" + movieName + "&page=\(page)"
        APIManager.shared.getRequest(url: url, viewController: self, showLoader: showLoader, for: Movies.self, success: { (response) in
            
            self.movies += response.results
            self.page = response.page
            self.totalPages = response.total_pages
            
            self.refreshCollectionView(shouldScrollToTop: shouldScrollToTop)
        }) { (error) in
            self.movies.removeAll()
            self.noMoviesFoundLbl(show: true)
            Utility.shared.showAlert(withMessage: error, from: self)
        }
    }
    
    func sortList(sortType: SortType) {
        self.movies.removeAll()
        switch sortType {
        case .Popularity:
            getPopularMovies(shouldScrollToTop: true)
        case .HighestRated:
            getHighestRatedMovies(shouldScrollToTop: true)
        }
    }
    
    func removeSearchBar() {
        searchBar.resignFirstResponder()
        refreshAfterSearch()
    }
    
    func setupSearchBar() {
        searchBar.resignFirstResponder()
        setupAfterSearch()
    }
    
    @objc func sortBtnTapped() {
        Utility.shared.sortDelegate = self
        Utility.shared.dropDown(on: UIBarButtonItem(customView: sortBtn), from: self)
    }
    
}


// MARK: - Search Bar Delegates
extension MoviesViewController: UISearchBarDelegate {
    
    @objc func searchBtnTapped() {
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        
        let searchBarText = searchBar.value(forKey: "searchField") as? UITextField
        searchBarText?.textColor = UIColor(rgb: TEXT_BLACK_COLOR)
        searchBarText?.font = .systemFont(ofSize: 15)
        
        let searchBarPlaceholder = searchBarText!.value(forKey: "placeholderLabel") as? UILabel
        searchBarPlaceholder?.textColor = UIColor(rgb: TEXT_GRAY_COLOR)
        
        searchBar.text = self.searchedMovie
        searchBar.placeholder = SEARCH_BAR_PLACEHOLDER
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor(rgb: TEXT_BLACK_COLOR)]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        self.navigationItem.leftBarButtonItems = nil
        self.navigationItem.titleView = searchBar
        
        searchBar.becomeFirstResponder()

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeSearchBar()
    }
    
    func enableSearchBarCancelButton(searchBar : UISearchBar) {
        for view1 in searchBar.subviews {
            for view2 in view1.subviews {
                if view2.isKind(of: UIButton.self) {
                    let button = view2 as! UIButton
                    button.isEnabled = true
                    button.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        enableSearchBarCancelButton(searchBar: searchBar)
        if let searchedMovie = searchBar.text {
            self.movies.removeAll()
            self.searchedMovie = searchedMovie
            searchMovie(movieName: searchedMovie, shouldScrollToTop: true)
        }
    }
    
    func refreshNavigationBar() {
        self.navigationItem.titleView = nil
        setupNavigationBar()
    }
    
    func hitApiBasedOnSort(shouldScrollToTop: Bool) {
        if sortSelected == .Popularity {
            getPopularMovies(shouldScrollToTop: shouldScrollToTop)
        } else {
            getHighestRatedMovies(shouldScrollToTop: shouldScrollToTop)
        }
    }
    
    func refreshAfterSearch() {
        refreshNavigationBar()
        self.movies.removeAll()
        self.searchedMovie = ""
        hitApiBasedOnSort(shouldScrollToTop: true)
    }
    
    func setupAfterSearch() {
        refreshNavigationBar()
    }
    
    
}

// MARK: - Collection View Data Source
extension MoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! MovieCollectionViewCell
        
        if let title = self.movies[indexPath.item].title {
            cell.movieTitleLabel.text = title
        }
        
        if let posterPath = self.movies[indexPath.item].posterPath {
            Utility.shared.setImage(from: IMAGE_BASE_URL + posterPath, on: cell.moviePosterImageView)
        } else if let backdropPath = self.movies[indexPath.item].backdropPath {
            Utility.shared.setImage(from: IMAGE_BASE_URL + backdropPath, on: cell.moviePosterImageView)
        }
        
        return cell
    }
    
    
}


// MARK: - Collection View Delegate
extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item + 1 == self.movies.count && self.page < self.totalPages {
            
            if searchedMovie != "" {
                searchMovie(page: self.page + 1, movieName: searchedMovie, shouldScrollToTop: false, showLoader: false)
            } else if sortSelected == .Popularity {
                getPopularMovies(page: self.page + 1, shouldScrollToTop: false, showLoader: false)
            } else {
                getHighestRatedMovies(page: self.page + 1, shouldScrollToTop: false, showLoader: false)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushToMovieInfoVC(movie: self.movies[indexPath.item])
    }
}


// MARK: - Collection View Delegate Flow Layout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utility.shared.moviewGridPosterWidth
        return CGSize(width: width, height: width * 1.5)
    }
}


// MARK: - Custom Delegate
extension MoviesViewController: SortOptionDelegate {
    
    func sortOptionSelected(type: SortType) {
        sortSelected = type
        sortList(sortType: sortSelected)
    }
    
}

// MARK: - Routes
extension MoviesViewController {
    
    func pushToMovieInfoVC(movie: Movie) {
        setupSearchBar()
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
            let movieInfoVC = storyboard.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
            movieInfoVC.movie = movie
            self.navigationController?.pushViewController(movieInfoVC, animated: true)
        }
    }
    
}






