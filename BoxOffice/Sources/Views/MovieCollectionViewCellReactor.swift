//
//  MovieCollectionViewCellReactor.swift
//  BoxOffice
//
//  Created by rae on 2023/01/05.
//

import Foundation

import ReactorKit
import RxSwift

final class MovieCollectionViewCellReactor: Reactor {
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        case requestMovieTmdb(Tmdb)
    }
    
    struct State {
        var rank: String?
        var rankInten: String?
        var isRankIntenUp: Bool = false
        var isNew: Bool = false
        var movieName: String?
        var openDate: String?
        var audienceAcc: String?
        
        var posterPath: String?
    }
    
    private let boxOfficeList: BoxOfficeList
    var initialState: State = State()
    
    init(boxOfficeList: BoxOfficeList) {
        self.boxOfficeList = boxOfficeList
        self.initialState = State(
            rank: boxOfficeList.rank,
            rankInten: self.setupRankInten(with: boxOfficeList),
            isRankIntenUp: self.setupIsRankIntenUp(with: boxOfficeList),
            isNew: boxOfficeList.rankOldAndNew == "NEW" ? true : false,
            movieName: boxOfficeList.movieName,
            openDate: "\(boxOfficeList.openDate.replacingOccurrences(of: "-", with: ".")) 개봉",
            audienceAcc: self.setupAudienceAcc(with: boxOfficeList)
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return TmdbRepository().getMovieTmdbResponse(
                movieName: self.boxOfficeList.movieName
            )
            .compactMap { $0.results.first?.toDomain() }
            .map { .requestMovieTmdb($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .requestMovieTmdb(let tmdb):
            newState.posterPath = "https://image.tmdb.org/t/p/w500\(tmdb.posterPath ?? "")"
        }
        
        return newState
    }
    
    private func setupRankInten(with boxOfficeList: BoxOfficeList) -> String? {
        if let rankIntenNum = Int(boxOfficeList.rankInten), rankIntenNum != 0 {
            if rankIntenNum > 0 {
                return "↑\(boxOfficeList.rankInten)"
            }
            return "↓\(boxOfficeList.rankInten.replacingOccurrences(of: "-", with: ""))"
        }
        return nil
    }
    
    private func setupIsRankIntenUp(with boxOfficeList: BoxOfficeList) -> Bool {
        if let rankIntenNum = Int(boxOfficeList.rankInten), rankIntenNum != 0 {
            if rankIntenNum > 0 {
                return true
            }
        }
        return false
    }
    
    private func setupAudienceAcc(with boxOfficeList: BoxOfficeList) -> String? {
        if let audienceAccNum = Int(boxOfficeList.audienceAcc) {
            if audienceAccNum < 10_000 {
                return "누적 \(boxOfficeList.audienceAcc)명"
            }
            return "누적 \(audienceAccNum / 10_000)만명"
        }
        return nil
    }
}
