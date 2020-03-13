//
//  MovieTableViewController.swift
//  MovieSearch
//
//  Created by Garrett Lyons on 3/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    var movies: [Movie] = []
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        tableView.rowHeight = 275
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell
    }
}//End of Class

// MARK: - Extension (Search Bar Delegate)
extension MovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = movieSearchBar.text,
            !searchTerm.isEmpty else { return }
        MovieController.fetchMovie(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
