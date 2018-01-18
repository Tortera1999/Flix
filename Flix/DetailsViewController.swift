//
//  DetailsViewController.swift
//  Flix
//
//  Created by Nikhil Iyer on 1/17/18.
//  Copyright © 2018 Nikhil Iyer. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    var movie: [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            titleLabel.text = movie["title"] as? String;
            overviewLabel.text = movie["overview"] as? String
            releaseLabel.text = movie["release_date"] as? String
            let backgroundUrl = movie["backdrop_path"] as? String
            let posterUrl = movie["poster_path"] as? String
            let baseUrl = "https://image.tmdb.org/t/p/w500";
            
            let UsePosterUrl = URL(string: (baseUrl + posterUrl!))
            let UseBackgroundUrl = URL(string: (baseUrl + backgroundUrl!))
            

            backgroundImageView.af_setImage(withURL: UseBackgroundUrl!)
            
            coverImageView.af_setImage(withURL: UsePosterUrl!)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
