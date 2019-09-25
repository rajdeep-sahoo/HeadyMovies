//
//  MoviesViewController.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 25/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Local Variables
    var movies: [Movie] = [Movie]()
    var page: Int = 0
    var totalPages: Int = 0
    
    let reuseId = "MovieCollectionViewCell"
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
}

