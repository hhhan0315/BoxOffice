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
        
        var movieName: String?
        var movieEnglishName: String?
        var info: String?
    }
    
    var initialState: State = State()
    
    init(movieInfo: MovieInfo?, tmdb: Tmdb?) {
        guard let movieInfo = movieInfo else {
            return
        }
        
        initialState.movieName = movieInfo.movieName
        initialState.movieEnglishName = movieInfo.movieNameEnglish
        initialState.info = self.setupInfo(with: movieInfo)
        
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
    
    private func setupInfo(with movieInfo: MovieInfo) -> String {
        var openDate = movieInfo.openDate
        [4, 7].forEach {
            openDate.insert(".", at: openDate.index(openDate.startIndex, offsetBy: $0))
        }
        
        let infos = [
            "\(openDate) 개봉",
            "\(movieInfo.showTime)분",
            "\(movieInfo.genreNames.joined(separator: ", "))",
            "\(movieInfo.watchGradeNames.first ?? "")"
        ]
        
        return infos.joined(separator: " | ")
    }
}
