//
//  MovieListItemViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct MovieListItemViewModel {
    
    var movieItem: MovieItem
    var tmdb: Tmdb?
    
    struct MovieItem {
        let rank: String
        var rankInten: String?
        var isRankIntenUp: Bool
        let isNew: Bool
        let movieCode: String
        let movieName: String
        let openDate: String
        var audienceAcc: String?
    }
    
    init(movie: Movie) {
        self.movieItem = .init(rank: movie.rank,
                               rankInten: nil,
                               isRankIntenUp: false,
                               isNew: movie.rankOldAndNew == "NEW" ? true : false,
                               movieCode: movie.movieCode,
                               movieName: movie.movieName,
                               openDate: "개봉 \(movie.openDate.replacingOccurrences(of: "-", with: "."))",
                               audienceAcc: nil)
        
        self.movieItem.rankInten = setupRankIntenNum(with: movie)
        self.movieItem.isRankIntenUp = setupIsRankIntenUp(with: movie)
        self.movieItem.audienceAcc = setupAudienceAcc(with: movie)
    }
    
    private func setupRankIntenNum(with movie: Movie) -> String? {
        if let rankIntenNum = Int(movie.rankInten), rankIntenNum != 0 {
            if rankIntenNum < 0 {
                return "↓\(movie.rankInten.replacingOccurrences(of: "-", with: ""))"
            } else {
                return "↑\(movie.rankInten)"
            }
        } else {
            return nil
        }
    }
    
    private func setupIsRankIntenUp(with movie: Movie) -> Bool {
        if let rankIntenNum = Int(movie.rankInten), rankIntenNum != 0 {
            if rankIntenNum < 0 {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    private func setupAudienceAcc(with movie: Movie) -> String? {
        if let audienceAccNum = Int(movie.audienceAcc) {
            if audienceAccNum < 10_000 {
                return "누적 \(movie.audienceAcc)"
            } else {
                return "누적 \(audienceAccNum / 10_000)만"
            }
        } else {
            return nil
        }
    }
}
