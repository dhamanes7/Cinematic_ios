//
//  ListFavoritesViewModel.swift
//  Cinematic
//
//  Created by Shubham Dhamane on 16/12/22.
//

import Foundation
import UIKit

class ListFavoritesViewModel {

    let viewTitle = "Favorite Filmes"
    var movieViewModel = MovieViewModel()
    var movieDataSource = MovieDataSource()
    var isLoadingMoreData = false
}

// MARK: - Requests
extension ListFavoritesViewModel {

    func fetchfavoriteMovies(nextPage: Bool, completion: @escaping (MovieViewModel) -> ()) {

        if isLoadingMoreData {
            return
        }

        isLoadingMoreData = true

        guard var page = self.movieViewModel.page else { return }

        if nextPage {
            guard let totalPages = self.movieViewModel.totalPages else { return }
            if page >= totalPages {
                isLoadingMoreData = false
                return
            }
            page += 1
        }

        self.movieDataSource.fetchMovies(page: page) {
            (viewModel, serviceError) in

            self.isLoadingMoreData = false

            if serviceError != nil {
                // TODO: Tratar erro
                return
            }

            if let viewModel = viewModel {
                self.movieViewModel.page = viewModel.page
                self.movieViewModel.totalPages = viewModel.totalPages
                if nextPage {
                    self.movieViewModel.movies?.append(contentsOf: viewModel.movies ?? [])
                } else {
                    self.movieViewModel.movies = viewModel.movies
                }

                completion(self.movieViewModel)
            }
        }
    }
}
