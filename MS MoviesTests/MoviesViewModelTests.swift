//
//  MoviesViewModelTests.swift
//  MS MoviesTests
//
//  Created by Mohammad Shaker on 9/9/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import XCTest
@testable import MS_Movies

class MoviesViewModelTests: XCTestCase {
    
    private var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        MoviesHistoryManager.clearMoviesHistory()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchHistory() {
        expectation = expectation(description: "Load Movies...")
        
        let viewModel = MoviesViewModel()
        viewModel.delegate = self
        viewModel.loadMovies(withKeyword: "Batman")
        waitForExpectations(timeout: 5)
        assert(MoviesHistoryManager.moviesHistory() == ["Batman"])
    }
    
    func testSearchNotFoundMovie() {
        expectation = expectation(description: "Load Movies...")
        
        let viewModel = MoviesViewModel()
        viewModel.delegate = self
        viewModel.loadMovies(withKeyword: "asdfghjkl")
        waitForExpectations(timeout: 5)
        assert(MoviesHistoryManager.moviesHistory() == [])
    }
    
    func testLoadMovies() {
        expectation = expectation(description: "Load Movies...")
        
        let viewModel = MoviesViewModel()
        viewModel.delegate = self
        viewModel.loadMovies(withKeyword: "Batman")
        waitForExpectations(timeout: 5)
        assert(viewModel.totalMoviesCount() == 20)
        assert(viewModel.totalMoviesHistoryCount() == 1)
        assert(viewModel.movieHistoryName(atIndex: 0) == "Batman")
        assert(viewModel.movie(atIndex: 0).title == "Batman")
        assert(viewModel.movie(atIndex: 0).releaseDate == "1989-06-23")
    }
}

extension MoviesViewModelTests: MoviesViewModelDelegate {
    func moviesLoadedSuccessfully() {
        expectation.fulfill()
    }
    
    func moviesFailedWithError(_ errorMessage: String) {
        expectation.fulfill()
    }
}
