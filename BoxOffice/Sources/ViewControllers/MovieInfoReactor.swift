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
    }
    
    struct State {
        var isLoading: Bool?
        var title: String?
    }
    
    var initialState: State = State()
    
    init(boxOfficeList: BoxOfficeList) {
        self.initialState = State(
            title: boxOfficeList.movieName
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                Observable.empty()
                    .delay(.seconds(5), scheduler: MainScheduler.instance),
                // Repository Detail 정보
                
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
}
