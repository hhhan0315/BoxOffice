//
//  MovieListReactor.swift
//  BoxOffice
//
//  Created by rae on 2023/01/04.
//

import Foundation

import ReactorKit
import RxSwift

final class MovieListReactor: Reactor {
    enum Action {
        case viewDidLoad
        case dailyButtonDidTap
    }
    
    enum Mutation {
        case setLoading(Bool)
        case requestDailyBoxOfficeList([MovieCollectionViewCellReactor])
    }
    
    struct State {
        var isLoading: Bool = false
        var movieCellReactors: [MovieCollectionViewCellReactor] = []
        var dailyButtonIsSelected: Bool = false
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                
                KobisRepository().getDailyBoxOfficeListResponse()
                    .map { $0.boxOfficeResult.dailyBoxOfficeList.map { $0.toDomain() } }
                    .map { $0.map { MovieCollectionViewCellReactor(boxOfficeList: $0) } }
                    .map { Mutation.requestDailyBoxOfficeList($0) },
                
                Observable.just(.setLoading(false))
            ])
            
        case .dailyButtonDidTap:
            return Observable.just(.setLoading(false))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .requestDailyBoxOfficeList(let movieCellReactors):
            newState.movieCellReactors = movieCellReactors
        }
        
        return newState
    }
}
