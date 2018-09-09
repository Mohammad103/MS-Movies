//
//  MoviesAPIManagerTests.swift
//  MS MoviesTests
//
//  Created by Mohammad Shaker on 9/9/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import XCTest
@testable import MS_Movies

class MoviesAPIManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchRequest() {
        var moviesResponse: MoviesResponse?
        let expectation = self.expectation(description: "Calling API")
        
        MoviesAPIManager.loadMovies(withKeywork: "Batman", pageNumber: 1, success: { (response) in
            moviesResponse = response
            XCTAssertNotNil(response, "No data was received.")
            expectation.fulfill()
        }, failure: { (errorMessage) in
            moviesResponse = nil
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        assert(moviesResponse?.page == 1)
        assert(moviesResponse?.totalPages == 6)
        assert(moviesResponse?.totalResults == 103)
        assert(moviesResponse?.movies?.count == 20)
    }
    
    func testSecondSearchPageRequest() {
        var moviesResponse: MoviesResponse?
        let expectation = self.expectation(description: "Calling API")
        
        MoviesAPIManager.loadMovies(withKeywork: "Batman", pageNumber: 2, success: { (response) in
            moviesResponse = response
            XCTAssertNotNil(response, "No data was received.")
            expectation.fulfill()
        }, failure: { (errorMessage) in
            moviesResponse = nil
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        assert(moviesResponse?.page == 2)
        assert(moviesResponse?.totalPages == 6)
        assert(moviesResponse?.totalResults == 103)
        assert(moviesResponse?.movies?.count == 20)
    }
    
    func testLastSearchPageRequest() {
        var moviesResponse: MoviesResponse?
        let expectation = self.expectation(description: "Calling API")
        
        MoviesAPIManager.loadMovies(withKeywork: "Batman", pageNumber: 6, success: { (response) in
            moviesResponse = response
            XCTAssertNotNil(response, "No data was received.")
            expectation.fulfill()
        }, failure: { (errorMessage) in
            moviesResponse = nil
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        assert(moviesResponse?.page == 6)
        assert(moviesResponse?.totalPages == 6)
        assert(moviesResponse?.totalResults == 103)
        assert(moviesResponse?.movies?.count == 3)
    }
    
}
