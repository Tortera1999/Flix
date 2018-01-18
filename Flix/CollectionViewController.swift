//
//  CollectionViewController.swift
//  Flix
//
//  Created by Nikhil Iyer on 1/17/18.
//  Copyright © 2018 Nikhil Iyer. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var movieLists: [[String: Any]] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        loadPosts();
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movieLists.count)
        return movieLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movieLists[indexPath.item] ;
        let posterUrlString = movie["poster_path"] as! String;
        let baseUrl = "https://image.tmdb.org/t/p/w500";
        let UsePosterUrl = URL(string: (baseUrl + posterUrlString))
        cell.posterImageView.af_setImage(withURL: UsePosterUrl!)
        
        return cell;
        
    }
    
    func loadPosts() {
        
//        refreshPic.startAnimating()
//        refreshPic.hidesWhenStopped = true
        
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
                self.collectionView.reloadData()
                //self.MovieTableView.reloadData()
            }
        }
        
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! PosterCell
        let vc = segue.destination as! DetailsViewController
        let index = collectionView.indexPath(for: cell)
        vc.movie = movieLists[(index?.row)!]
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
