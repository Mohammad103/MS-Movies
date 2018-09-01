//
//  Constants.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/1/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "http://api.themoviedb.org/3/search"
        static let baseImageURL = "​http://image.tmdb.org/t/p/w92"
    }
    
    struct MoviesAPIParameterKey {
        static let apiKey = "api_key"
        static let keyword = "query"
        static let pageNumber = "page"
    }
}
