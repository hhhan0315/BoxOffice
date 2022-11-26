//
//  MovieDetailItemViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/26.
//

import Foundation

final class MovieDetailItemViewModel {
    let prdtYear: String
    let showTime: String
    let genreNames: String
    let directorNames: [String]
    let actorNames: [String]
    let watchGradeName: String
    
    init(movieDetail: MovieDetail) {
        self.prdtYear = movieDetail.prdtYear
        self.showTime = "\(movieDetail.showTime)분"
        self.genreNames = movieDetail.genreNames.joined(separator: "/")
        self.directorNames = movieDetail.directorNames
        self.actorNames = movieDetail.actorNames
        self.watchGradeName = movieDetail.watchGradeNames.first ?? ""
    }
}
