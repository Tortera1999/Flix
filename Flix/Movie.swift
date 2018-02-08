//
//  Movie.swift
//  Flix
//
//  Created by Nikhil Iyer on 2/7/18.
//  Copyright © 2018 Nikhil Iyer. All rights reserved.
//

import Foundation

class Movie {
    
    var title: String
    var descript: String
    var movieUrl: String
    var fullUrl: String
    var posterUrl: URL?
    var backdropUrl: URL?
    var backgroundUrl: String
    var releaseDate: String
    
    init(moviedictionary: [String: Any]) {
        title = moviedictionary["title"] as? String ?? "No title"
        descript = moviedictionary["overview"] as? String ?? "No Description"
        movieUrl = moviedictionary["poster_path"] as? String ?? "No Url"
        backgroundUrl = moviedictionary["backdrop_path"] as? String ?? "No Backdrop Url"
        fullUrl = "https://image.tmdb.org/t/p/w500" + movieUrl;
        posterUrl = URL(string: (fullUrl));
        backdropUrl = URL(string: ("https://image.tmdb.org/t/p/w500" + backgroundUrl));
        releaseDate = moviedictionary["release_date"] as? String ?? "No Release Date"
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(moviedictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }

}
