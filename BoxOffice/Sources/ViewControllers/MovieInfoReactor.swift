//
//  MovieInfoReactor.swift
//  BoxOffice
//
//  Created by rae on 2023/01/06.
//

import Foundation

import ReactorKit

final class MovieInfoReactor: Reactor {
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        case setLoading(Bool)
        case requestMovieInfo(MovieInfo)
        case requestTmdb(Tmdb)
    }
    
    struct State {
        var isLoading: Bool?
        var movieInfo: MovieInfo?
        var tmdb: Tmdb?
    }
    
    private let boxOfficeList: BoxOfficeList
    let initialState: State = State()
    
    init(boxOfficeList: BoxOfficeList) {
        self.boxOfficeList = boxOfficeList
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                KobisRepository().getMovieInfoResponse(with: self.boxOfficeList.movieCode)
                    .map { $0.movieInfoResult.movieInfo.toDomain() }
                    .map { Mutation.requestMovieInfo($0) },
                
                TmdbRepository().getMovieTmdbResponse(movieName: self.boxOfficeList.movieName)
                    .compactMap { $0.results.first?.toDomain() }
                    .map { Mutation.requestTmdb($0) },
                
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .requestMovieInfo(let movieInfo):
            newState.movieInfo = movieInfo
            
        case .requestTmdb(let tmdb):
            newState.tmdb = tmdb
        }
        
        return newState
    }
}
