//
//  MovieInfoOverviewTableViewCellReactor.swift
//  BoxOffice
//
//  Created by rae on 2023/01/07.
//

import Foundation

import ReactorKit

final class MovieInfoOverviewTableViewCellReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var overview: String?
    }
    
    var initialState: State = State()
    
    init(movieInfo: MovieInfo?, tmdb: Tmdb?) {
        guard let tmdb = tmdb else {
            return
        }
        
        initialState.overview = tmdb.overview
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
