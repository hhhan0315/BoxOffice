//
//  TmdbRepository.swift
//  BoxOffice
//
//  Created by rae on 2023/01/04.
//

import Foundation

import RxSwift

final class TmdbRepository {
    private let networkService = NetworkService()
    private let key = Secrets.tmdbKey
    
    func getMovieTmdbResponse(movieName: String) -> Observable<MovieTmdbResponseDTO> {
        let request = MovieTmdbRequestDTO(apiKey: self.key, query: movieName)
        let api = TmdbAPI.getSearchMovie(request)
        let urlRequest = api.urlRequest
        return networkService.execute(urlRequest: urlRequest)
    }
}
