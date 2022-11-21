//
//  BoxOfficeList.swift
//  BoxOffice
//
//  Created by rae on 2022/11/21.
//

import Foundation

struct BoxOfficeList {
    let rank: String // 순위
    let rankInten: String // 전일대비 순위 증감분
    let rankOldAndNew: String // 랭킹 신규진입여부
    let movieCode: String // 영화 대표코드
    let movieName: String // 영화명 국문
    let openDate: String // 개봉일
    let audienceAcc: String // 누적 관객수
    
    let backdropPath: String? // 배경 이미지
    let posterPath: String? // 포스터 이미지
    let tmdbID: Int? // tmdb id
    let overview: String? // 영화 줄거리
    
    let showTime: String? // 상영시간
    let genres: [String]? // 장르이름
    let directors: [String]? // 감독
    let actors: [String]? // 배우
//    let companys: [String] // 참여 영화사
    let watchGrade: String? // 관람등급
}