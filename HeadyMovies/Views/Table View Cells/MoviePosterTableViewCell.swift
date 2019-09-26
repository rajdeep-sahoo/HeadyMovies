//
//  MoviePosterTableViewCell.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 26/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

class MoviePosterTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
}


extension MoviePosterTableViewCell {
    
    func setupCell() {
        moviePosterImgView.layer.borderColor = UIColor.gray.cgColor
        moviePosterImgView.layer.borderWidth = 0.5
        moviePosterImgView.layer.cornerRadius = 5
    }
    
}


