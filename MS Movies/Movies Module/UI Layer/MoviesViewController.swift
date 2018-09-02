//
//  MoviesViewController.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/1/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import UIKit
import SCLAlertView
import SVProgressHUD
import DZNEmptyDataSet
import UIScrollView_InfiniteScroll

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var refreshControl = UIRefreshControl()
    
    private var viewModel = MoviesViewModel()
    private var keyword = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBarStyles()
        self.configureSearchBarStyles()
        self.configureTableView()
        
        self.viewModel.delegate = self
        
        self.refreshControl.addTarget(self, action: #selector(reloadMovies), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(self.refreshControl)
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
    
    func configureTableView() {
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
        
        self.tableView.addInfiniteScroll { (tableView) -> Void in
            self.viewModel.loadMovies(withKeyword: self.keyword)
        }
        
        tableView.setShouldShowInfiniteScrollHandler { _ -> Bool in
            return self.viewModel.shouldLoadMore
        }
    }
    
    @objc func reloadMovies() {
        SVProgressHUD.show()
        self.viewModel.reloadMovies(withKeyword: keyword)
    }
}

extension MoviesViewController: MoviesViewModelDelegate {
    func moviesLoadedSuccessfully() {
        SVProgressHUD.dismiss()
        self.refreshControl.endRefreshing()
        self.tableView.finishInfiniteScroll()
        self.tableView.reloadData()
    }
    
    func moviesFailedWithError(_ errorMessage: String) {
        SVProgressHUD.dismiss()
        self.refreshControl.endRefreshing()
        self.tableView.finishInfiniteScroll()
        
        SCLAlertView().showError("Error", subTitle: errorMessage)
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
        self.keyword = searchBar.text!
        self.reloadMovies()
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

extension MoviesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "No movies available"
        
        let attributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : UIColor.darkGray,
            .font : UIFont.boldSystemFont(ofSize: 16)
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
}
