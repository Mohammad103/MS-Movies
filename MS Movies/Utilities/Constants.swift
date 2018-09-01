//
//  Constants.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/1/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import Foundation
import UIKit

struct K {
    struct ProductionServer {
        static let baseURL = "http://api.themoviedb.org/3/search"
        static let baseImageURL = "http://image.tmdb.org/t/p/w92"
    }
    
    struct MoviesAPIParameterKey {
        static let apiKey = "api_key"
        static let keyword = "query"
        static let pageNumber = "page"
    }
    
    struct Color {
        static let primaryColor = UIColor(red: 55.0/255, green: 180.0/255, blue: 78.0/255, alpha: 1.0)
    }
}
