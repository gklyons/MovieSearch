//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Garrett Lyons on 3/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            movieTitleLabel.text = movie.title
            movieRatingLabel.text = "Rating: \(movie.rating)"
            movieDescriptionLabel.text = "Summary: \(movie.description)"
            
            MovieController.fetchImage(movie: movie) { (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.posterImage.image = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
