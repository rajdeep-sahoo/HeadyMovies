//
//  MovieCollectionViewCell.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 25/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTitleLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var moviePosterImageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

}

extension MovieCollectionViewCell {
    
    func setupCell() {
        
        movieTitleLabel.textColor = UIColor(rgb: TEXT_BLACK_COLOR)
        movieTitleLabelWidthConstraint.constant = Utility.shared.moviewGridPosterWidth - 10
        moviePosterImageViewHeightConstraint.constant = Utility.shared.moviewGridPosterWidth * 1.5
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5
        
    }
    
}


