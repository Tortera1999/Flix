//
//  MovieCell.swift
//  Flix
//
//  Created by Nikhil Iyer on 1/10/18.
//  Copyright © 2018 Nikhil Iyer. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
