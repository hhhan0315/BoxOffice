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
    }
    
    enum Mutation {
        case setLoading(Bool)
        case requestBoxOfficeList([MovieCollectionViewCellReactor])
        case showAlertMessage(NetworkError?)
    }
    
    struct State {
        var isLoading: Bool?
        var movieCellReactors: [MovieCollectionViewCellReactor] = []
        var networkError: NetworkError?
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                KobisRepository().getDailyBoxOfficeListResponse()
                    .map { $0.boxOfficeResult.dailyBoxOfficeList.map { $0.toDomain() } }
                    .map { $0.map { MovieCollectionViewCellReactor(boxOfficeList: $0) } }
                    .map { Mutation.requestBoxOfficeList($0) },
                
                Observable.just(Mutation.setLoading(false))
            ])
            .catch { error in
                    .concat([
                        Observable.just(Mutation.showAlertMessage(error as? NetworkError)),
                        Observable.just(Mutation.setLoading(false))
                    ])
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .requestBoxOfficeList(let movieCellReactors):
            newState.movieCellReactors = movieCellReactors
            
        case .showAlertMessage(let networkError):
            newState.networkError = networkError
        }
        
        return newState
    }
}
