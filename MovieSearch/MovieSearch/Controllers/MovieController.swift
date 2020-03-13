//
//  MovieController.swift
//  MovieSearch
//
//  Created by Garrett Lyons on 3/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//
//////// API reference https://api.themoviedb.org/3/search/movie?api_key=503f0bae1d2d764c31baee5f20818ae7
//////// API Key: 503f0bae1d2d764c31baee5f20818ae7

import UIKit

class MovieController {
    
    static private let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static private let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w185/")
    static private let apiKey = "503f0bae1d2d764c31baee5f20818ae7"
    
    static func fetchMovie(searchTerm: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        //1)
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey), URLQueryItem(name:"query", value: searchTerm)
        ]
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        //2)
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            //3)
            if let error = error { return completion(.failure(.thrown(error))) }
            //4)
            guard let data = data else { return completion(.failure(.noData)) }
            //5)
            do {
                let topLevelMovie = try JSONDecoder().decode((TopLevelMovie.self), from: data)
                completion(.success(topLevelMovie.results))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    static func fetchImage(movie: Movie, completion: @escaping (Result<UIImage, MovieError>) -> Void) {

        guard let imageBaseURL = imageBaseURL else { return completion(.failure(.invalidURL)) }
        guard let moviePoster = movie.poster else { return completion(.failure(.noData)) }

        let url = imageBaseURL.appendingPathComponent(moviePoster)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { return completion(.failure(.thrown(error))) }
            guard let data = data else { return completion(.failure(.noData)) }
            guard let image = UIImage(data: data) else { return completion(.failure(.noData)) }
            completion(.success(image))
        }.resume()
    }
}//End of Class
