//
//  MovieInfoTitleTableViewCellReactor.swift
//  BoxOffice
//
//  Created by rae on 2023/01/06.
//

import Foundation

import ReactorKit

final class MovieInfoTitleTableViewCellReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var posterPath: String?
        var backdropPath: String?
    }
    
    var initialState: State = State()
    
    init(movieInfo: MovieInfo?, tmdb: Tmdb?) {
        guard let tmdb = tmdb else {
            return
        }
        
        initialState.posterPath = tmdb.posterPath
        initialState.backdropPath = tmdb.backdropPath
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
