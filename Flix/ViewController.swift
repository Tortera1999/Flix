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
    var movieLists: [[String: Any]] = [];
    @IBOutlet weak var refreshPic: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //refreshPic.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.gray;
        refreshPic.startAnimating()
        
        refreshController.addTarget(self, action: #selector(ViewController.refreshControlAction(_:)), for: .valueChanged)
        MovieTableView.insertSubview(refreshController, at: 0)
        
        
        MovieTableView.delegate = self
        MovieTableView.dataSource = self
        
        loadPosts()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
//            self.refreshPic.stopAnimating()
//            self.refreshPic.isHidden = true
//        }
        
        
        
    }
    
    func loadPosts() {
        
        refreshPic.startAnimating()
        refreshPic.hidesWhenStopped = true
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            //This will run when network request returns
            if let error = error{
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movieLists = movies;
                self.MovieTableView.reloadData()
                            }
        }
        
        task.resume()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieLists.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
            let moviePost = movieLists[indexPath.row]
            let movieTitle = moviePost["title"] as! String
            let movieDescription  = moviePost["overview"] as! String
            let baseUrl = "https://image.tmdb.org/t/p/w500";
            let movieUrl = moviePost["poster_path"] as! String;
            let url = URL(string: (baseUrl + movieUrl))
        
            cell.titleLabel.text = movieTitle
            cell.overviewLabel.text = movieDescription
            cell.photoImageView.af_setImage(withURL: url!)
            self.refreshPic.stopAnimating()
        
        return cell
    }
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        loadPosts()
        self.refreshController.endRefreshing()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! MovieCell
        let vc = segue.destination as! DetailsViewController
        let index = MovieTableView.indexPath(for: cell)
        vc.movie = movieLists[(index?.row)!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

