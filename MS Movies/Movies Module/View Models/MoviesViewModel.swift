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
        if !self.shouldLoadMore {
            return
        }
        
        MoviesAPIManager.loadMovies(withKeywork: keyword, pageNumber: self.pageNumber, success: { (response) in
            
            self.pageNumber += 1
            if response.page == response.totalPages {
                self.shouldLoadMore = false
            }
            if let movies = response.movies {
                MoviesHistoryManager.saveMovieToHistory(movieName: keyword)
                
                self.movies.append(contentsOf: movies)
                self.delegate?.moviesLoadedSuccessfully()
            } else {
                self.delegate?.moviesFailedWithError("There is no movie with this name in the database.")
            }
            
        }, failure: { (errorMessage) in
            self.delegate?.moviesFailedWithError(errorMessage)
        })
    }
    
    func reloadMovies(withKeyword keyword: String) {
        self.movies = []
        self.pageNumber = 1
        self.shouldLoadMore = true
        self.loadMovies(withKeyword: keyword)
    }
    
    func totalMoviesCount() -> Int {
        return self.movies.count
    }
    
    func movie(atIndex index: Int) -> Movie {
        return self.movies[index]
    }
    
    func totalMoviesHistoryCount() -> Int {
        return MoviesHistoryManager.moviesHistory().count
    }
    
    func movieHistoryName(atIndex index: Int) -> String {
        return MoviesHistoryManager.moviesHistory()[index]
    }
}
