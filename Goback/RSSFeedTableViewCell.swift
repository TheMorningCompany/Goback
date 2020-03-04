//
//  RSSFeedTableViewCell.swift
//  Goback
//
//  Created by Julian Wright on 3/3/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class RSSFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 3
        }
    }
    @IBOutlet weak var pubDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: RSSItem! {
        didSet {
            //set title, desc, pubDate label texts
            titleLabel.text = item.title
            descriptionLabel.text = item.description
            pubDateLabel.text = item.pubDate
        }
    }

}
