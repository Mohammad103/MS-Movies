//
//  SearchTableViewCell.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/5/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setupCell(withSearchText searchText: String) {
        self.titleLabel.text = searchText
        self.iconImageView.image = UIImage(named: "search")
    }

}
