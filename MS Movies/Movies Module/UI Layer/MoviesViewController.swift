//
//  MoviesViewController.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/1/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel = MoviesViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.configureNavigationBarStyles()
        self.configureSearchBarStyles()
        
        self.viewModel.delegate = self
        self.viewModel.reloadMovies(withKeyword: "")
    }
    
    func configureNavigationBarStyles() {
        self.navigationController?.navigationBar.barTintColor = K.Color.primaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 16)!]
        
        self.navigationController?.navigationBar.shadowImage = UIColor.from(color: K.Color.primaryColor)
        self.navigationController?.navigationBar.setBackgroundImage(UIColor.from(color: K.Color.primaryColor), for: .default)
    }
    
    func configureSearchBarStyles() {
        self.searchBar.setBackgroundImage(UIColor.from(color: K.Color.primaryColor), for: .any, barMetrics: .default)
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.white
    }

}

extension MoviesViewController: MoviesViewModelDelegate {
    func moviesLoadedSuccessfully() {
        self.tableView.reloadData()
    }
    
    func moviesFailedWithError(_ errorMessage: String) {
        
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.setupCell(withMovie: self.viewModel.movie(atIndex: indexPath.row))
        return cell
    }
}


extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.viewModel.reloadMovies(withKeyword: searchBar.text!)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
