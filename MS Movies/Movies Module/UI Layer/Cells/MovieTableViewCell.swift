//
//  MovieTableViewCell.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/1/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    func convertDateFormater(_ dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateStr)
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date!)
    }
    
    func setupCell(withMovie movie: Movie) {
        self.titleLabel.text = movie.title
        self.overviewLabel.text = movie.overview
        
        if (movie.releaseDate != nil && movie.releaseDate != "") {
            self.releaseDateLabel.text = self.convertDateFormater(movie.releaseDate!)
        }
        
        self.containerView.layer.cornerRadius = 5.0
        
        let imageURL = K.ProductionServer.baseImageURL + (movie.posterPath ?? "")
        self.posterImageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
    }

}
