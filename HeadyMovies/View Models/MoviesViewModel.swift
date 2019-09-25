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
        setupCollectionView()
        getPopularMovies()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBtnTapped))
        searchBtn.tintColor = .black

        let sortBtn: UIBarButtonItem = {
            
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "sort_icon"), for: .normal)
            button.contentMode = .scaleAspectFit
            button.addTarget(self, action: #selector(sortBtnTapped), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            button.widthAnchor.constraint(equalToConstant: 20).isActive = true
            button.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            let tabItem = UIBarButtonItem(customView: button)
            return tabItem
            
        }()
        
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = searchBtn
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = sortBtn
    }
    
    func setupCollectionView() {
        collectionView?.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseId)
        collectionView?.backgroundColor = UIColor(rgb: BACKGROUND_COLOR)
    }
    
    func getPopularMovies(page: Int = 1) {
        let url = "/movie/popular?api_key=\(TMDB_API_KEY)&language=en-US&page=\(page)"
        APIManager.shared.getRequest(url: url, viewController: self, for: Movies.self, success: { (response) in
            
            self.movies += response.results
            self.page = response.page
            self.totalPages = response.total_pages
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }) { (error) in
            Utility.shared.showAlert(withMessage: error, from: self)
        }
    }
    
    @objc func searchBtnTapped() {
        print("Lorem Ipsum")
    }
    
    @objc func sortBtnTapped() {
        print("Lorem Ipsum")
    }
    
}

// MARK: - Collection View Data Source
extension MoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! MovieCollectionViewCell
        cell.movieTitleLabel.text = self.movies[indexPath.item].title
        Utility.shared.setImage(from: IMAGE_BASE_URL + self.movies[indexPath.item].posterPath, on: cell.moviePosterImageView)
        return cell
    }
    
    
}


// MARK: - Collection View Delegate
extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item + 1 == self.movies.count && self.page < self.totalPages {
            getPopularMovies(page: self.page + 1)
        }
    }
}


// MARK: - Collection View Delegate Flow Layout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utility.shared.moviewGridPosterWidth
        return CGSize(width: width, height: width * 1.5)
    }
}
