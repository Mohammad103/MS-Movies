//
//  MoviesViewModel.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/2/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import UIKit

protocol MoviesViewModelDelegate: AnyObject {
    func moviesLoadedSuccessfully()
    func moviesFailedWithError(_ errorMessage: String)
}


class MoviesViewModel {
    
    weak var delegate: MoviesViewModelDelegate?
    
    private var pageNumber = 1
    var shouldLoadMore = true
    var movies: [Movie] = []
    

    func loadMovies(withKeyword keyword: String) {
        MoviesAPIManager.loadMovies(withKeywork: keyword, pageNumber: self.pageNumber, success: { (response) in
            self.pageNumber += 1
            if let movies = response.movies {
                self.movies.append(contentsOf: movies)
            }
            self.delegate?.moviesLoadedSuccessfully()
        }, failure: { (errorMessage) in
            self.delegate?.moviesFailedWithError(errorMessage)
        })
    }
    
    func reloadMovies(withKeyword keyword: String) {
        self.movies = []
        self.pageNumber = 1
        self.loadMovies(withKeyword: keyword)
    }
    
    func totalMoviesCount() -> Int {
        return self.movies.count
    }
    
    func movie(atIndex index: Int) -> Movie {
        return self.movies[index]
    }
    
}
