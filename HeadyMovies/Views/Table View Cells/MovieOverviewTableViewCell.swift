//
//  MovieOverviewTableViewCell.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 26/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

class MovieOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var plotSynopsisLbl: UILabel!
    @IBOutlet weak var movieOverviewLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
}


extension MovieOverviewTableViewCell {
    
    func setupCell() {
        plotSynopsisLbl.textColor = UIColor(rgb: TEXT_BLACK_COLOR)
        movieOverviewLbl.textColor = UIColor(rgb: TEXT_BLACK_COLOR)
        
        plotSynopsisLbl.text = PLOT_SYNOPSIS
    }
    
}


