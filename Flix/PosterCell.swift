//
//  PosterCell.swift
//  Flix
//
//  Created by Nikhil Iyer on 1/17/18.
//  Copyright © 2018 Nikhil Iyer. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie!{
        didSet {
            posterImageView.af_setImage(withURL: movie.posterUrl!)
        }
    }
    
}
