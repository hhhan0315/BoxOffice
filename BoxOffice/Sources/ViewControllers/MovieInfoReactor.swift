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
        case requestReviews([Review])
    }
    
    struct State {
        var boxOfficeList: BoxOfficeList?
        
        var isLoading: Bool?
        var movieInfo: MovieInfo?
        var tmdb: Tmdb?
        
        var reviews: [Review] = []
    }
    
    var initialState: State = State()
    
    init(boxOfficeList: BoxOfficeList) {
        self.initialState.boxOfficeList = boxOfficeList
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            guard let boxOfficeList = self.currentState.boxOfficeList else {
                return Observable.empty()
            }
            
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                KobisRepository().getMovieInfoResponse(with: boxOfficeList.movieCode)
                    .map { $0.movieInfoResult.movieInfo.toDomain() }
                    .map { Mutation.requestMovieInfo($0) },
                
                TmdbRepository().getMovieTmdbResponse(movieName: boxOfficeList.movieName)
                    .compactMap { $0.results.first?.toDomain() }
                    .map { Mutation.requestTmdb($0) },
                
                FirebaseRepository().fetchReviews(movieCode: boxOfficeList.movieCode)
                    .map { Mutation.requestReviews($0) },
                
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
            
        case .requestReviews(let reviews):
            newState.reviews = reviews
        }
        
        return newState
    }
}
