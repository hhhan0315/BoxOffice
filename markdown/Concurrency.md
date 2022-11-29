# Swift Concurrency
# asnyc & await 도입
- Swift 5.5에서 등장
- Xcode 13.2부터 iOS 13에서도 사용 가능

## 도입 이유

```swift
apiService.request(api: KobisAPI.getDailyBoxOfficeList(date: yesterday), dataType: DailyBoxOfficeDTO.self) { [weak self] result in
    switch result {
    case .success(let dailyBoxOfficeDTO):
        let dailyBoxOfficeLists = dailyBoxOfficeDTO.boxOfficeResult.dailyBoxOfficeList
        
        dailyBoxOfficeLists.forEach {
            let year = String($0.openDt.prefix(4))
            
            self?.apiService.request(api: TmdbAPI.getSearchMovie(movieName: $0.movieNm, openYear: year), dataType: TmdbDTO.self, completion: { [weak self] result in
                switch result {
                case .success(let tmdbDTO):
                    let result = tmdbDTO.results.first
                    
                case .failure(let apiError):
                    print(apiError.rawValue)
                }
            })
        }
    case .failure(let apiError):
        print(apiError.rawValue)
    }
}
```

- 원하는 구현을 위해 영화진흥위원회 API 요청 -> TMDB API 요청으로 이루어진다.
- 요청이 2가지뿐인데도 콜백지옥이라고 불리는 경우를 볼 수 있었고 복잡해보였다.


