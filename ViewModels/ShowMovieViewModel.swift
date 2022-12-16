//
//  ShowMovieViewModel.swift
//  Cinematic
//
//  Created by Gurpreet Kaur on 2022-12-15.
//

import Foundation

class ShowMovieViewModel {

    var movie = Movie()
        let movieService = MovieService()
        let movieDataSource = MovieDataSource()
        var isFavorite = false
}

// MARK: - Requests
extension ShowMovieViewModel {

    func fetchMovie(completion: @escaping (Movie) -> ()) {
        guard let id = self.movie.id else { return }
        self.movieService.fetchMovie(with: id) {
            (movie, serviceError) in

            if serviceError != nil {
                // TODO: Tratar erro
                return
            }

            if let movie = movie {
                self.movie.genres = movie.genres
                completion(self.movie)
            }
        }
    }
// fetch movie data
    func checkFavorite(completion: @escaping (Movie) -> ()) {
        movieDataSource.fetchMovie(movie: movie) { (movie, dataSourceError) in
            if dataSourceError != nil {
                self.isFavorite = false
            }

            if movie != nil {
                self.isFavorite = true
            }

            completion(self.movie)
        }
    }
// while adding favourite
    func tougleIsfavorite(completion: @escaping (Movie) -> ()) {
        if isFavorite {
            movieDataSource.removeMovie(movie: movie) { (movie, dataSourceError) in
                if dataSourceError != nil {
                    // TODO: tratar erro
                }

                self.isFavorite = false
                completion(self.movie)
            }
        } else {
            movieDataSource.saveMovie(movie: movie) { (movie, dataSourceError) in
                if dataSourceError != nil {
                    // TODO: tratar erro
                }

                self.isFavorite = true
                completion(self.movie)
            }
        }
    }
}
// save data
