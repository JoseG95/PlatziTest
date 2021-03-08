//
//  NetworkServices.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 05/03/21.
//

import Foundation
import UIKit

struct NetworkServices {
    private static var apiKey = "7d93b0bb995db9da3c4cbd3c8164cf41"
    private static let baseUrl = "https://api.themoviedb.org/3/movie"
    private static func popularMovies(page: Int) -> String {
        return "\(baseUrl)/popular?api_key=\(apiKey)&page=\(page)"
    }
    private static func moviePoster(posterPath: String) -> String {
        return "https://image.tmdb.org/t/p/w200/\(posterPath)"
    }
    private static func recommendationsFor(_ movieId: Int) -> String {
        return "\(baseUrl)/\(movieId)/recommendations"
    }
    
    static func fetchPopularMovies(page: Int, completionHandler: @escaping (MoviesPage) -> Void) {
        guard let url = URL(string: self.popularMovies(page: page)) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error with fetching movies: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let movies = try? JSONDecoder().decode(MoviesPage.self, from: data) {
                completionHandler(movies)
            }
        }
        task.resume()
    }
    
    static func getMovieImage(from posterPath: String, completionHandler: @escaping ((Data) -> Void)) {
        guard let url = URL(string: self.moviePoster(posterPath: posterPath)) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error getting movie image: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                completionHandler(data)
            }
        }
        task.resume()
    }
    
    static func fetchRecommendedMovies(for movieId: Int, completionHandler: @escaping ((MoviesPage) -> Void)) {
        guard let url = URL(string: self.recommendationsFor(movieId)) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error getting movie recommendations: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let movies = try? JSONDecoder().decode(MoviesPage.self, from: data) {
                completionHandler(movies)
            }
        }
        task.resume()
    }
}
