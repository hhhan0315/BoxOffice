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
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var rank: String?
        var rankInten: String?
        var isRankIntenUp: Bool = false
        var isNew: Bool = false
        var movieName: String?
        var openDate: String?
        var audienceAcc: String?
    }
    
    var initialState: State = State()
    
    init(boxOfficeList: BoxOfficeList) {
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
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
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
                return "누적 \(boxOfficeList.audienceAcc)"
            }
            return "누적 \(audienceAccNum / 10_000)만"
        }
        return nil
    }
}
