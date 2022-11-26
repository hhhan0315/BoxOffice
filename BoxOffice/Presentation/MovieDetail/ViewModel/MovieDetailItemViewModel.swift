//
//  MovieDetailItemViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/26.
//

import Foundation

final class MovieDetailItemViewModel {
    let rank: String
    let rankInten: String?
    let isRankIntenUp: Bool
    let isNew: Bool
//    let movieCode: String
    let movieName: String
    let openDate: String
    let audienceAcc: String?
    
    let backdropPath: String?
    let posterPath: String?
    let tmdbId: Int?
    let overview: String?
    
    let prdtYear: String
    let showTime: String
    let genreNames: String
    let directorNames: [String]
    let actorNames: [String]
    let watchGradeName: String
    
    init(movieListItemViewModel: MovieListItemViewModel, movieDetail: MovieDetail) {
        self.rank = movieListItemViewModel.rank
        self.rankInten = movieListItemViewModel.rankInten
        self.isRankIntenUp = movieListItemViewModel.isRankIntenUp
        self.isNew = movieListItemViewModel.isNew
//        self.movieCode = movieListItemViewModel
        self.movieName = movieListItemViewModel.movieName
        self.openDate = movieListItemViewModel.openDate
        self.audienceAcc = movieListItemViewModel.audienceAcc
        
        self.backdropPath = movieListItemViewModel.backdropPath
        self.posterPath = movieListItemViewModel.posterPath
        self.tmdbId = movieListItemViewModel.tmdbId
        self.overview = movieListItemViewModel.overview
        
        self.prdtYear = movieDetail.prdtYear
        self.showTime = "\(movieDetail.showTime)분"
        self.genreNames = movieDetail.genreNames.joined(separator: "/")
        self.directorNames = movieDetail.directorNames
        self.actorNames = movieDetail.actorNames
        self.watchGradeName = movieDetail.watchGradeNames.first ?? ""
    }
}
