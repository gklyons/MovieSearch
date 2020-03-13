//
//  Movie.swift
//  MovieSearch
//
//  Created by Garrett Lyons on 3/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

    //////// API reference  https://api.themoviedb.org/3/movie/76341?api_key=<<api_key>>
    //////// API Key: 503f0bae1d2d764c31baee5f20818ae7

import Foundation

struct TopLevelMovie: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let rating: Double
    let description: String
    var poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case description = "overview"
        case poster = "poster_path"
    }
}
