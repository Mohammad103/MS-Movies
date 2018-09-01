//
//  MoviesAPIManager.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/1/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import UIKit
import Alamofire

class MoviesAPIManager: NSObject {
    
    class func loadMovies(withKeywork keywork: String, pageNumber: Int) {
        
        Alamofire.request(MoviesRouter.movies(keywork: keywork, page: pageNumber)).responseJSON { (response) in
            
            switch response.result {
            case .success:
                
                do {
                    let decoder = JSONDecoder()
                    let moviesResponse = try decoder.decode(MoviesResponse.self, from: response.data!)
                    print(moviesResponse)
                    
                } catch let error {
                    print("Parsing failed with error: \(error)")
                }
                
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    class func loadMovies(pageNumber: Int) {
        self.loadMovies(withKeywork: "", pageNumber: pageNumber)
    }
    
}
