//
//  MovieInfoTableViewCellReactor.swift
//  BoxOffice
//
//  Created by rae on 2023/01/06.
//

import Foundation

import ReactorKit

final class MovieInfoTableViewCellReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var movieName: String?
        var movieEnglishName: String?
        var info: String?
        
        var posterPath: String?
    }
    
    var initialState: State = State()
    
    init(movieInfo: MovieInfo?, tmdb: Tmdb?) {
        guard let movieInfo = movieInfo else {
            return
        }
        
        self.initialState.movieName = movieInfo.movieName
        self.initialState.movieEnglishName = movieInfo.movieNameEnglish
        self.initialState.info = "\(movieInfo.prdtYear) • \(movieInfo.nationNames.joined(separator: "/")) • \(movieInfo.genreNames.joined(separator: "/"))"
        
        guard let tmdb = tmdb else {
            return
        }
        
        self.initialState.posterPath = tmdb.posterPath
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
