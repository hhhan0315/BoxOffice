//
//  MoviePosterRequestDTO.swift
//  BoxOffice
//
//  Created by rae on 2022/11/30.
//

import Foundation

struct MoviePosterRequestDTO {
    let apiKey: String
    let language: String = "ko"
    let query: String
    let region: String = "KR"
    let year: String
}
