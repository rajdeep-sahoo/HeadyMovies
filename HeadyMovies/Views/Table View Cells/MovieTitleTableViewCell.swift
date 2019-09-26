//
//  MovieTitleTableViewCell.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 26/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

class MovieTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
}


extension MovieTitleTableViewCell {
    
    func setupCell() {
        movieTitleLbl.textColor = UIColor(rgb: TEXT_BLACK_COLOR)
    }
    
}


