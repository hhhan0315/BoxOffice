//
//  MovieListItemViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct MovieListItemViewModel {
    let rank: String
    let rankInten: String?
    let isNew: Bool
    let movieCode: String
    let movieName: String
    let openDate: String
    let audienceAcc: String?
    
    let backdropPath: String?
    let posterPath: String?
    let tmdbId: Int?
    let overview: String?
    
    init(movie: Movie, tmdb: Tmdb?) {
        self.rank = movie.rank
        self.isNew = movie.rankOldAndNew == "NEW" ? true : false
        self.movieCode = movie.movieCode
        self.movieName = movie.movieName
        self.openDate = "개봉 \(movie.openDate.replacingOccurrences(of: "-", with: "."))"
        
        if let rankIntenNum = Int(movie.rankInten), rankIntenNum != 0 {
            if rankIntenNum < 0 {
                self.rankInten = "▼\(movie.rankInten.replacingOccurrences(of: "-", with: ""))"
            } else {
                self.rankInten = "▲\(movie.rankInten)"
            }
        } else {
            self.rankInten = nil
        }
        
        if let audienceAccNum = Int(movie.audienceAcc) {
            if audienceAccNum < 10_000 {
                self.audienceAcc = "누적 \(movie.audienceAcc)"
            } else {
                self.audienceAcc = "누적 \(audienceAccNum / 10_000)만"
            }
        } else {
            self.audienceAcc = nil
        }
        
        
        if let tmdb = tmdb {
            self.backdropPath = tmdb.backdropPath
            self.posterPath = tmdb.posterPath
            self.tmdbId = tmdb.id
            self.overview = tmdb.overview
        } else {
            self.backdropPath = nil
            self.posterPath = nil
            self.tmdbId = nil
            self.overview = nil
        }
    }
}
