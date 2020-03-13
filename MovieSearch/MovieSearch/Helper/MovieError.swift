//
//  MovieError.swift
//  MovieSearch
//
//  Created by Garrett Lyons on 3/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

enum MovieError: LocalizedError {
    case invalidURL
    case noData
    case thrown(Error)
    case failedToDelete
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach API."
        case .noData:
            return "The server responded with no data."
        case .thrown(let error):
            return error.localizedDescription
        case .failedToDelete:
            return "Unable to delete resource from the server."
        }
    }
}
