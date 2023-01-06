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
        case dailyButtonDidTap
        case weekButtonDidTap
        case weekendButtonDidTap
        case weekdaysButtonDidTap
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setButtonDidSelected(KobisWeekType)
        case requestBoxOfficeList([MovieCollectionViewCellReactor])
        case showAlertMessage(NetworkError?)
    }
    
    struct State {
        var isLoading: Bool?
        var buttonDidSelected: KobisWeekType = .daily
        var movieCellReactors: [MovieCollectionViewCellReactor] = []
        var networkError: NetworkError?
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .dailyButtonDidTap:
            return Observable.concat([
                Observable.just(Mutation.requestBoxOfficeList([])),
                
                Observable.just(Mutation.setLoading(true)),
                
                Observable.just(Mutation.setButtonDidSelected(.daily)),
                
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
            
        case .weekButtonDidTap:
            return self.setupWeekButtonDidTap(with: .week)
            
        case .weekendButtonDidTap:
            return self.setupWeekButtonDidTap(with: .weekend)
            
        case .weekdaysButtonDidTap:
            return self.setupWeekButtonDidTap(with: .weekdays)
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .setButtonDidSelected(let kobisWeekType):
            newState.buttonDidSelected = kobisWeekType
            
        case .requestBoxOfficeList(let movieCellReactors):
            newState.movieCellReactors = movieCellReactors
            
        case .showAlertMessage(let networkError):
            newState.networkError = networkError
        }
        
        return newState
    }
    
    private func setupWeekButtonDidTap(with kobisWeekType: KobisWeekType) -> Observable<Mutation> {
        return Observable.concat([
            Observable.just(Mutation.requestBoxOfficeList([])),
            
            Observable.just(Mutation.setLoading(true)),
            
            Observable.just(Mutation.setButtonDidSelected(kobisWeekType)),
            
            KobisRepository().getWeeklyBoxOfficeListResponse(with: kobisWeekType)
                .map { $0.boxOfficeResult.weeklyBoxOfficeList.map { $0.toDomain() } }
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
