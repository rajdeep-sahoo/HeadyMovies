//
//  Movie.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 25/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

struct Movie: Decodable {
    let backdropPath: String?
    let posterPath: String?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case backdropPath = "backdrop_path", posterPath = "poster_path", originalTitle = "original_title", releaseDate = "release_date", voteAverage = "vote_average"
    }
}

struct Movies: Decodable {
    let results: [Movie]
    let page: Int
    let total_results: Int
    let total_pages: Int
}


