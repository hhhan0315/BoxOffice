//
//  MovieListItemViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct MovieListItemViewModel {
    let rank: String
    let isNew: Bool
    let movieName: String
    let openDate: String
    let posterPath: String?
    
    var rankInten: String? = nil
    var isRankIntenUp: Bool = false
    var audienceAcc: String? = nil
    
    init(movie: Movie) {
        self.rank = movie.boxOfficeList.rank
        self.isNew = movie.boxOfficeList.rankOldAndNew == "NEW" ? true : false
        self.movieName = movie.boxOfficeList.movieName
        self.openDate = "\(movie.boxOfficeList.openDate.replacingOccurrences(of: "-", with: ".")) 개봉"
        self.posterPath = movie.tmdb?.posterPath
        
        self.rankInten = setupRankInten(with: movie.boxOfficeList)
        self.isRankIntenUp = setupIsRankIntenUp(with: movie.boxOfficeList)
        self.audienceAcc = setupAudienceAcc(with: movie.boxOfficeList)
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
    
    private func setupIsRankIntenUp(with movie: BoxOfficeList) -> Bool {
        if let rankIntenNum = Int(movie.rankInten), rankIntenNum != 0 {
            if rankIntenNum > 0 {
                return true
            }
        }
        return false
    }
    
    private func setupAudienceAcc(with movie: BoxOfficeList) -> String? {
        if let audienceAccNum = Int(movie.audienceAcc) {
            if audienceAccNum < 10_000 {
                return "누적 \(movie.audienceAcc)"
            }
            return "누적 \(audienceAccNum / 10_000)만"
        }
        return nil
    }
}
