//
//  MovieInfoContentTableViewCellReactor.swift
//  BoxOffice
//
//  Created by rae on 2023/01/06.
//

import Foundation

import ReactorKit

final class MovieInfoContentTableViewCellReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var directorName: String?
        var showTime: String?
        var watchGradeName: String?
        var genreNames: String?
        var nationNames: String?
        var prdtYear: String?
        
        var overview: String?
    }
    
    var initialState: State = State()
    
    init(movieInfo: MovieInfo?, tmdb: Tmdb?) {
        guard let movieInfo = movieInfo else {
            return
        }
        
        initialState.directorName = movieInfo.directorNames.first
        initialState.showTime = "\(movieInfo.showTime)분"
        initialState.watchGradeName = movieInfo.watchGradeNames.first
        initialState.genreNames = movieInfo.genreNames.joined(separator: "/")
        initialState.nationNames = movieInfo.nationNames.joined(separator: "/")
        initialState.prdtYear = movieInfo.prdtYear
        
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
