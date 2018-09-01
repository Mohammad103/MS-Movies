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
    
    class func loadMovies(withKeywork keywork: String, pageNumber: Int, success: (_: MoviesResponse) -> Void, failure: (_: String) -> Void) {
        
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
    
    class func loadMovies(pageNumber: Int, success: (_: MoviesResponse) -> Void, failure: (_: String) -> Void) {
        self.loadMovies(withKeywork: "", pageNumber: pageNumber, success: { (response) in
            success(response)
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
    
}
