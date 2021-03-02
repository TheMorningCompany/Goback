//
//  RSSFeedTableViewCell.swift
//  Goback
//
//  Created by Julian Wright on 3/3/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

enum CellState {
    case expanded
    case collapsed
}

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 1
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var dateLabel: UILabel!

    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            descriptionLabel.text = item.description
            dateLabel.text = item.pubDate
        }
    }
    
}
