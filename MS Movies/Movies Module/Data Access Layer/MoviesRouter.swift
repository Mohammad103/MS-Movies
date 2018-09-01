//
//  MoviesRouter.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/1/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import UIKit
import Alamofire

enum MoviesRouter: URLRequestConvertible {
    case movies(keywork: String, page: Int)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .movies:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .movies(let keywork, let page):
            return "/movie?api_key=2696829a81b1b5827d515ff121700838&query=\(keywork)&page=\(page)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .movies:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = K.ProductionServer.baseURL + path
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
