//
//  BoxOfficeListViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/18.
//

import Foundation

final class BoxOfficeListViewModel {
    // input
    // 1. viewDidLoad 시 네트워크 통신으로 일별 데이터 가져오기
    // 2. 버튼 클릭 시 알맞은 네트워크 통신 후 데이터 가져오기
    // 3. item 클릭 시 세부 화면으로 이동 (이건 Coordinator 패턴)
    
    // output
    // 배열 [BoxOfficeList] -> 만들어줘야함
    // 일별 네트워크 통신 -> 세부정보 네트워크 통신 -> 해당 정보로 TMDB API 호출 -> 포스터 정보도 해당 배열에 넣어줘야함
    
//    private let apiService = APIService()
    
    var movies: [Movie] = []
//    {
//        didSet {
//            reloadTableViewClosure?()
//        }
//    }
    
    var loadingStartClosure: (() -> Void)?
    var loadingEndClosure: (() -> Void)?
    var reloadTableViewClosure: (() -> Void)?
    
    // dailyBoxOfficeList -> movieCd로 Detail 조회 -> moviewNm으로 TMDB API 조회 -> poster 정보 -> 전체 BoxOfficeList 모델 만들 수 있음
    // 1. dailyBoxOfficeList로 먼저 일별 박스오피스 조회하고 boxOfficeLists에 값 넣기
    // 2. boxOfficeLists에서 반복문을 돌면서 detail 조회하고 값 최신화
    // 3. boxOfficeLists에서 반복문을 돌면서 TMDB 조회하고 값 최신화(포스터 정보 등)
    // 결국 제목 먼저 보여주고 그 다음에 이미지 보여줌(딜레이가 너무 오래걸리는 것을 방지)
    
    // cell click하면 detailBoxOfficeList
    // 해당 id로 -> video search -> type trailer filter -> 해당 key 저장 -> Youtube api 호출
    
//    private func fetchMovies(with boxOfficeLists: [BoxOfficeListDTO]) {
//        let movies = boxOfficeLists.map { Movie(movieInfo: $0.toDomain(), movieDetailInfo: nil, tmdbInfo: nil) }
//        self.movies.append(contentsOf: movies)
//        loadingEndClosure?()
//        reloadTableViewClosure?()
//    }
//    
//    private func fetchTmdbInfo() {
//        Task {
//            do {
//                for (index, movie) in movies.enumerated() {
//                    let movieName = movie.movieInfo.movieName
//                    let openYear = String(movie.movieInfo.openDate.prefix(4))
//                    let tmdbResponseDTO = try await apiService.request(api: TmdbAPI.getSearchMovie(movieName: movieName, openYear: openYear), dataType: TmdbResponseDTO.self)
//
//                    let tmdbResult = tmdbResponseDTO.results.first
//                    let tmdbInfo = tmdbResult.map { $0.toDomain() }
//                    
//                    movies[index].tmdbInfo = tmdbInfo
//                }
//                reloadTableViewClosure?()
//            } catch let error as APIError {
//                print(error.rawValue)
//            }
//        }
//        
//    }
//    
//    func fetchDaily() {
//        movies.removeAll()
//        
//        reloadTableViewClosure?()
//        
//        loadingStartClosure?()
//        Task {
//            do {
//                let yesterday = Date.yesterday.toString(dateFormat: .yyyyMMdd)
//                let dailyResponseDTO = try await apiService.request(api: KobisAPI.getDailyBoxOfficeList(date: yesterday), dataType: DailyResponseDTO.self)
//                let dailyBoxOfficeLists = dailyResponseDTO.boxOfficeResult.dailyBoxOfficeList
//                
//                fetchMovies(with: dailyBoxOfficeLists)
//
//                fetchTmdbInfo()
//            } catch let error as APIError {
//                print(error.rawValue)
//            }
//        }
//    }
//    
//    func fetch(with weekType: WeekType) {
//        movies.removeAll()
//        
//        reloadTableViewClosure?()
//        loadingStartClosure?()
//        Task {
//            do {
//                let oneWeekAgo = Date.oneWeekAge.toString(dateFormat: .yyyyMMdd)
//                let weeklyResponseDTO = try await apiService.request(api: KobisAPI.getWeeklyBoxOfficeList(date: oneWeekAgo, weekType: weekType), dataType: WeeklyResponseDTO.self)
//                let weeklyBoxOfficeLists = weeklyResponseDTO.boxOfficeResult.weeklyBoxOfficeList
//                
//                fetchMovies(with: weeklyBoxOfficeLists)
//                
//                fetchTmdbInfo()
//            } catch let error as APIError {
//                print(error.rawValue)
//            }
//        }
//    }
}
