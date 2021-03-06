//
//  NetworkServices.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 05/03/21.
//

import Foundation

struct NetworkServices {
    private static var apiKey = "7d93b0bb995db9da3c4cbd3c8164cf41"
    private static let baseUrl = "https://api.themoviedb.org/3/movie"
    private static func popularMovies(page: Int) -> String {
        return "\(baseUrl)/popular?api_key=\(apiKey)&page=\(page)"
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
}
