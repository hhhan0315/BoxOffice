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
    
    // 1. 로딩 시작 시 indicator 표시
    // 2. 로딩 종료 시 indicator 종료
    
    private let apiService = APIService()
    
    var boxOfficeLists: [BoxOfficeList] = [] {
        didSet {
            reloadTableViewClosure?()
        }
    }
    
    var reloadTableViewClosure: (() -> Void)?
    
    private func getYesterdayString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return nil
        }
        
        return dateFormatter.string(from: yesterday)
    }
    
    // dailyBoxOfficeList -> movieCd로 Detail 조회 -> moviewNm으로 TMDB API 조회 -> poster 정보 -> 전체 BoxOfficeList 모델 만들 수 있음
    // 1. dailyBoxOfficeList로 먼저 일별 박스오피스 조회하고 boxOfficeLists에 값 넣기
    // 2. boxOfficeLists에서 반복문을 돌면서 detail 조회하고 값 최신화
    // 3. boxOfficeLists에서 반복문을 돌면서 TMDB 조회하고 값 최신화(포스터 정보 등)
    // 결국 제목 먼저 보여주고 그 다음에 이미지 보여줌(딜레이가 너무 오래걸리는 것을 방지)
    
    // cell click하면 detailBoxOfficeList
    // 해당 id로 -> video search -> type trailer filter -> 해당 key 저장 -> Youtube api 호출
    
    func fetch() {
        getDailyBoxOfficeList()
    }
    
    private func getDailyBoxOfficeList() {
        guard let yesterday = getYesterdayString() else {
            return
        }
        
        apiService.request(api: KobisAPI.getDailyBoxOfficeList(date: yesterday), dataType: DailyBoxOfficeDTO.self) { result in
            switch result {
            case .success(let dailyBoxOfficeDTO):
                let dailyBoxOfficeLists = dailyBoxOfficeDTO.boxOfficeResult.dailyBoxOfficeList
                dailyBoxOfficeLists.forEach {
                    let boxOfficeList = BoxOfficeList(
                        rank: $0.rank,
                        rankInten: $0.rankInten,
                        rankOldAndNew: $0.rankOldAndNew,
                        movieCode: $0.movieCd,
                        movieName: $0.movieNm,
                        openDate: $0.openDt,
                        audienceAcc: $0.audiAcc,
                        backdropPath: nil,
                        posterPath: nil,
                        tmdbID: nil,
                        overview: nil,
                        showTime: nil,
                        genres: nil,
                        directors: nil,
                        actors: nil,
                        watchGrade: nil
                    )
                    self.boxOfficeLists.append(boxOfficeList)
                }
                
//                for dailyBoxOfficeList in dailyBoxOfficeLists {
//                    self.apiService.request(api: KobisAPI.getMovieInfo(movieCode: dailyBoxOfficeList.movieCd), dataType: MovieDetailDTO.self) { result in
//                        switch result {
//                        case .success(let movieDetailDTO):
//                            let movieInfo = movieDetailDTO.movieInfoResult.movieInfo
//                            let openYear = String(dailyBoxOfficeList.openDt.prefix(4))
//
//                            self.apiService.request(api: TmdbAPI.getSearchMovie(movieName: dailyBoxOfficeList.movieNm, openYear: openYear), dataType: TmdbDTO.self) { result in
//                                switch result {
//                                case .success(let tmdbDTO):
//                                    let tmdbResult = tmdbDTO.results.first
//                                    let boxOfficeList = BoxOfficeList(
//                                        rank: dailyBoxOfficeList.rank,
//                                        rankInten: dailyBoxOfficeList.rankInten,
//                                        rankOldAndNew: dailyBoxOfficeList.rankOldAndNew,
//                                        movieCode: dailyBoxOfficeList.movieCd,
//                                        movieName: dailyBoxOfficeList.movieNm,
//                                        openDate: dailyBoxOfficeList.openDt,
//                                        audienceAcc: dailyBoxOfficeList.audiAcc,
//                                        backdropPath: tmdbResult?.backdropPath,
//                                        posterPath: tmdbResult?.posterPath,
//                                        tmdbID: tmdbResult?.id,
//                                        overview: tmdbResult?.overview,
//                                        showTime: movieInfo.showTm,
//                                        genres: movieInfo.genres.map { String($0.genreNm) },
//                                        directors: movieInfo.directors.map { String($0.peopleNm) },
//                                        actors: movieInfo.actors.map { String($0.peopleNm) },
//                                        watchGrade: movieInfo.audits.first?.watchGradeNm ?? ""
//                                    )
//                                    self.boxOfficeLists.append(boxOfficeList)
//                                case .failure:
//                                    break
//                                }
//                            }
//                        case .failure:
//                            break
//                        }
//                    }
//                }
                
            case .failure:
                break
            }
        }
    }
    
//    private func getDailyBoxOfficeList() async throws -> [BoxOfficeList] {
//        guard let yesterday = getYesterdayString() else {
//            return
//        }
        

//        let dailyBoxOfficeDTO = try await apiService.request(api: KobisAPI.getDailyBoxOfficeList(date: getYesterdayString()!), dataType: DailyBoxOfficeDTO.self)
//        let dailyBoxOfficeLists = dailyBoxOfficeDTO.boxOfficeResult.dailyBoxOfficeList
//        
//        try await withThrowingTaskGroup(of: (DailyBoxOfficeDTO, TmdbDTO).self, body: { group in
//            for dailyBoxOfficeList in dailyBoxOfficeLists {
//                group.addTask {
//                    let openYear = String(dailyBoxOfficeList.openDt.prefix(4))
//                    let tmdbDTO = try await self.apiService.request(api: TmdbAPI.getSearchMovie(movieName: dailyBoxOfficeList.movieNm, openYear: openYear), dataType: TmdbDTO.self)
//                    return (dailyBoxOfficeDTO, tmdbDTO)
//                }
//            }
//            
//            for try await (dailyBoxOfficeDTO, tmdbDTO) in group {
//                let dailyBoxOfficeLists = dailyBoxOfficeDTO.boxOfficeResult.dailyBoxOfficeList
//                
//                for dailyBoxOfficeList in dailyBoxOfficeLists {
//                    <#body#>
//                }
//                
//                if let tmdbResult = tmdbDTO.results.first {
//                    let boxOfficeList = BoxOfficeList(rank: <#T##String#>, rankInten: <#T##String#>, rankOldAndNew: <#T##String#>, movieCode: <#T##String#>, movieName: <#T##String#>, openDate: <#T##String#>, audienceAcc: <#T##String#>, backdropPath: <#T##String?#>, posterPath: <#T##String?#>, id: <#T##Int#>)
//                }
//            }
//        })
        
//        dailyBoxOfficeLists.forEach {
//            let openYear = String($0.openDt.prefix(4))
//            let tmdbDTO = try await apiService.request(api: TmdbAPI.getSearchMovie(movieName: $0.movieNm, openYear: openYear), dataType: TmdbDTO.self)
//        }
//    }
    
    
    
    
    
    //        apiService.request(api: KobisAPI.getDailyBoxOfficeList(date: yesterday), dataType: DailyBoxOfficeDTO.self) { [weak self] result in
    //            switch result {
    //            case .success(let dailyBoxOfficeDTO):
    //                let dailyBoxOfficeLists = dailyBoxOfficeDTO.boxOfficeResult.dailyBoxOfficeList
    //
    //                dailyBoxOfficeLists.forEach {
    //                    let year = String($0.openDt.prefix(4))
    //
    //                    self?.apiService.request(api: TmdbAPI.getSearchMovie(movieName: $0.movieNm, openYear: year), dataType: TmdbDTO.self, completion: { [weak self] result in
    //                        switch result {
    //                        case .success(let tmdbDTO):
    //                            let result = tmdbDTO.results.first
    //
    //
    //                        case .failure(let apiError):
    //                            print(apiError.rawValue)
    //                        }
    //                    })
    //                }
    //            case .failure(let apiError):
    //                print(apiError.rawValue)
    //            }
    //        }
}

