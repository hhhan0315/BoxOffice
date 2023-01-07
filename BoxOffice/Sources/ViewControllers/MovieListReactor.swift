//
//  MovieListReactor.swift
//  BoxOffice
//
//  Created by rae on 2023/01/04.
//

import Foundation

import ReactorKit

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
        case requestBoxOfficeLists([BoxOfficeList])
        case showAlertMessage(NetworkError?)
    }
    
    struct State {
        var isLoading: Bool?
        var buttonDidSelected: KobisWeekType?
        var boxOfficeLists: [BoxOfficeList] = []
        var networkError: NetworkError?
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .dailyButtonDidTap:
            return self.setupButtonDidTap(with: .daily)
            
        case .weekButtonDidTap:
            return self.setupButtonDidTap(with: .week)
            
        case .weekendButtonDidTap:
            return self.setupButtonDidTap(with: .weekend)
            
        case .weekdaysButtonDidTap:
            return self.setupButtonDidTap(with: .weekdays)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .setButtonDidSelected(let kobisWeekType):
            newState.buttonDidSelected = kobisWeekType
            
        case .requestBoxOfficeLists(let boxOfficeLists):
            newState.boxOfficeLists = boxOfficeLists
            
        case .showAlertMessage(let networkError):
            newState.networkError = networkError
        }
        
        return newState
    }
    
    private func setupButtonDidTap(with kobisWeekType: KobisWeekType) -> Observable<Mutation> {
        return Observable.concat([
            Observable.just(Mutation.requestBoxOfficeLists([])),
            
            Observable.just(Mutation.setLoading(true)),
            
            Observable.just(Mutation.setButtonDidSelected(kobisWeekType)),
            
            self.setupBoxOfficeListResponse(with: kobisWeekType),
            
            Observable.just(Mutation.setLoading(false))
        ])
        .catch { error in
                .concat([
                    Observable.just(Mutation.showAlertMessage(error as? NetworkError)),
                    Observable.just(Mutation.setLoading(false))
                ])
        }
    }
    
    private func setupBoxOfficeListResponse(with kobisWeekType: KobisWeekType) -> Observable<Mutation> {
        switch kobisWeekType {
        case .daily:
            return KobisRepository().getDailyBoxOfficeListResponse()
                .map { $0.boxOfficeResult.dailyBoxOfficeList.map { $0.toDomain() } }
                .map { Mutation.requestBoxOfficeLists($0) }
        case .week, .weekend, .weekdays:
            return KobisRepository().getWeeklyBoxOfficeListResponse(with: kobisWeekType)
                .map { $0.boxOfficeResult.weeklyBoxOfficeList.map { $0.toDomain() } }
                .map { Mutation.requestBoxOfficeLists($0) }
        }
    }
}
