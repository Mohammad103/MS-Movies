//
//  MoviesHistoryMangerTests.swift
//  MS MoviesTests
//
//  Created by Mohammad Shaker on 9/7/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import XCTest
@testable import MS_Movies

class MoviesHistoryMangerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        MoviesHistoryManager.clearMoviesHistory()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSaveMovie() {
        MoviesHistoryManager.saveMovieToHistory(movieName: "Batman")
        assert(MoviesHistoryManager.moviesHistory() == ["Batman"])
    }
    
    func testSaveDuplicateMovie() {
        MoviesHistoryManager.saveMovieToHistory(movieName: "Batman")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Batman")
        assert(MoviesHistoryManager.moviesHistory() == ["Batman"])
    }
    
    func testSaveOldMovieAgain() {
        MoviesHistoryManager.saveMovieToHistory(movieName: "Batman")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Superman")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Batman")
        assert(MoviesHistoryManager.moviesHistory() == ["Batman", "Superman"])
    }
    
    func testSaveMoreThan10Movies() {
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 01")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 02")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 03")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 04")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 05")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 06")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 07")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 08")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 09")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 10")
        MoviesHistoryManager.saveMovieToHistory(movieName: "Movie 11")
        assert(MoviesHistoryManager.moviesHistory() == ["Movie 11", "Movie 10", "Movie 09", "Movie 08", "Movie 07", "Movie 06", "Movie 05", "Movie 04", "Movie 03", "Movie 02"])
    }
}
