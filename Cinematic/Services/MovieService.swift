//
//  MovieService.swift
//  Cinematic
//
//  Created by Gurpreet Kaur on 2022-12-15.
//

import Foundation
class MovieService: Service {

    // MARK: - Requests

    func fetchPopularMovies(with
        page: Int,
        completion: @escaping (Movie?, MovieServiceError?) -> ()) {

        let query = [
            URLQueryItem(name: "page", value: "\(page)")
        ]

        let path = "/movie/popular"

        guard let url = createApiUrl(with: path, queryItems: query) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }
                guard let data = data else {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }

                let decoder = JSONDecoder()
                decoder.setCustomDateDecodingStrategy()

                let result = try decoder.decode(Movie.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetch())
            }
        }).resume()
    }

    func fetchMovie(with
        id: Int,
        completion: @escaping (Movie?, MovieServiceError?) -> ()) {

        let path = "/movie/\(id)"

        guard let url = createApiUrl(with: path, queryItems: []) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, MovieServiceError.CannotFetchMovie())
                    return
                }
                guard let data = data else {
                    completion(nil, MovieServiceError.CannotFetchMovie())
                    return
                }

                let decoder = JSONDecoder()
                decoder.setCustomDateDecodingStrategy()

                let result = try decoder.decode(Movie.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetchMovie())
            }
        }).resume()
    }

    func fetchMovies(with
        search: String,
        page: Int,
        completion: @escaping (Movie?, MovieServiceError?) -> ()) {

        let query = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "query", value: search)
        ]

        let path = "/search/movie"

        guard let url = createApiUrl(with: path, queryItems: query) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }
                guard let data = data else {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }

                let decoder = JSONDecoder()
                decoder.setCustomDateDecodingStrategy()

                let result = try decoder.decode(Movie.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetch())
            }
        }).resume()
    }
}

// MARK: - Request errors

enum MovieServiceError: Equatable, Error {
    case CannotFetch(String = "Error while loading " +
                              "verify internet connection.")
    case CannotFetchMovie(String = "Error while loading" +
                                   "Check your inteernet connection.")
}
