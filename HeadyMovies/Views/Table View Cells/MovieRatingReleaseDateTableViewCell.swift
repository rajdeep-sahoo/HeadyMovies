//
//  MovieRatingReleaseDateTableViewCell.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 26/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

class MovieRatingReleaseDateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var releaseDateContainerView: UIView!
    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var movieRatingLbl: UILabel!
    @IBOutlet weak var movieReleaseDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
}


extension MovieRatingReleaseDateTableViewCell {
    
    func setupCell() {
        ratingContainerView.layer.cornerRadius = ratingContainerView.frame.size.height / 2
        ratingContainerView.layer.borderWidth = 3
        ratingContainerView.layer.borderColor = UIColor(rgb: GREEN_COLOR).cgColor
        
        releaseDateContainerView.layer.cornerRadius = 3
        
        releaseDateLbl.textColor = UIColor(rgb: TEXT_BLACK_COLOR)
        releaseDateLbl.text = RELEASED_ON
    }
    
}


