//
//  MoviesResponse.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/1/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import Foundation

struct MoviesResponse : Codable {
    
    let results : [Movie]?
    let page : Int?
    let totalPages : Int?
    let totalResults : Int?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case page = "page"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([Movie].self, forKey: .results)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }
    
}
