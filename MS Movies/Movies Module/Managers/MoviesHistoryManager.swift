//
//  MoviesHistoryManager.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/6/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import UIKit

class MoviesHistoryManager {
    
    class func moviesHistory() -> [String] {
        return UserDefaults.standard.array(forKey: K.UserDefaultsKey.moviesHistory) as? [String] ?? []
    }
    
    class func saveMovieToHistory(movieName: String) {
        let maxElements = 10
        var list: [String] = moviesHistory()
        list = list.filter { $0 != movieName }
        list.insert(movieName, at: 0)
        list = Array(list.prefix(maxElements))
        UserDefaults.standard.set(list, forKey: K.UserDefaultsKey.moviesHistory)
    }
    
}
