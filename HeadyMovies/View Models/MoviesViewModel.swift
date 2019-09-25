//
//  MoviesViewModel.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 25/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

// MARK: - Local Methods
extension MoviesViewController {
    
    func getPopularMovies() {
        let url = "movie/popular?api_key=\(TMDB_API_KEY)&language=en-US&page=1"
        APIManager.shared.getRequest(url: url, viewController: self, for: Movies.self, success: { (response) in
            print(response)
        }) { (error) in
            Utility.shared.showAlert(withMessage: error, from: self)
        }
    }
    
}
