//
//  MovieListItemViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct MovieListItemViewModel {
    let rank: String
    var rankInten: String? = nil
    var isRankIntenUp: Bool = false
    var isNew: Bool = false
//    let movieCode: String
    let movieName: String
    let openDate: String
    var audienceAcc: String? = nil
    
//    let backdropPath: String?
    let posterPath: String?
//    let id: Int?
//    let overview: String?
    
    init(movie: Movie) {
        self.rank = movie.boxOfficeList.rank
//        self.movieCode = movie.boxOfficeList.movieCode
        self.movieName = movie.boxOfficeList.movieName
        self.openDate = "\(movie.boxOfficeList.openDate.replacingOccurrences(of: "-", with: ".")) 개봉"
        
//        self.backdropPath = movie.tmdb?.backdropPath
        self.posterPath = movie.tmdb?.posterPath
//        self.id = movie.tmdb?.id
//        self.overview = movie.tmdb?.overview
        
        self.rankInten = setupRankInten(with: movie.boxOfficeList)
        self.isRankIntenUp = setupIsRankIntenUp(with: movie.boxOfficeList)
        self.isNew = movie.boxOfficeList.rankOldAndNew == "NEW" ? true : false
        self.audienceAcc = setupAudienceAcc(with: movie.boxOfficeList)
    }
    
    private func setupRankInten(with boxOfficeList: BoxOfficeList) -> String? {
        if let rankIntenNum = Int(boxOfficeList.rankInten), rankIntenNum != 0 {
            if rankIntenNum < 0 {
                return "↓\(boxOfficeList.rankInten.replacingOccurrences(of: "-", with: ""))"
            } else {
                return "↑\(boxOfficeList.rankInten)"
            }
        } else {
            return nil
        }
    }
    
    private func setupIsRankIntenUp(with movie: BoxOfficeList) -> Bool {
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
    
    private func setupAudienceAcc(with movie: BoxOfficeList) -> String? {
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
