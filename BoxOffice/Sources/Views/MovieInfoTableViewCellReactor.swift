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
//        case viewDidLoad
    }
    
    enum Mutation {
        
    }
    
    struct State {
//        var movieName: String?
//        var movieEnglishName: String?
    }
    
    var initialState: State = State()
    
    init(boxOfficeList: BoxOfficeList) {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
