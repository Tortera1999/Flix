//
//  ViewController.swift
//  Flix
//
//  Created by Nikhil Iyer on 1/10/18.
//  Copyright © 2018 Nikhil Iyer. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var MovieTableView: UITableView!
    let refreshController = UIRefreshControl();
    @IBOutlet weak var refreshPic: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshPic.startAnimating()
        
        refreshController.addTarget(self, action: #selector(ViewController.refreshControlAction(_:)), for: .valueChanged)
        MovieTableView.insertSubview(refreshController, at: 0)
        
        
        MovieTableView.delegate = self
        MovieTableView.dataSource = self
        
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.MovieTableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
        cell.movie = movies[indexPath.row];
        self.refreshPic.stopAnimating()
        
        return cell
    }
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.MovieTableView.reloadData()
            }
        }
        self.refreshController.endRefreshing()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! MovieCell
        let vc = segue.destination as! DetailsViewController
        let index = MovieTableView.indexPath(for: cell)
        vc.movie = movies[(index?.row)!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

