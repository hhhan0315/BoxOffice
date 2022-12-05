# 도대체 왜 하는걸까?
- 사실 적용하고 만들어진 것을 보면 파일만 많아지고 더 복잡하게 보여서 이렇게 사용해야 하는 이유를 마음 깊이 공감은 잘 못하겠다.
- 다양한 블로그 글들을 보고 그 중에 마음에 와닿은 이유들을 적어보고자 한다.

## 서버가 존재하지 않을 경우 개발을 시작해야할 때
- 참고 : https://velog.io/@whale/Swift-Clean-Architecture
- 화면에 그려질 데이터는 결국 `Entity`를 사용한다.
- 서버가 주는 데이터를 그대로 쓰지 않고 `ResponseDTO`의 `domain()` 메서드를 통해 우리가 필요로 하는 `Entity`로 변경하게 된다.
- 그렇다는 것은 우리가 필요로 하는 `Entity`는 미리 구현할 수 있다고 이야기할 수 있다.
- 그리고 테스트 데이터를 통해 현재 앱이 내가 원하는 UI로 나타나는지 확인할 수 있다.

```swift
final class MockMoviesRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension MockMoviesRepository: MoviesRepository {
    func fetchDailyMovieList() async throws -> [BoxOfficeList] {
        sleep(1)
        return [BoxOfficeList.dummyBoxOfficeList]
    }
    
    func fetchWeeklyMovieList(with kobisWeekType: KobisWeekType) async throws -> [BoxOfficeList] {
        return [BoxOfficeList.dummyBoxOfficeList]
    }
    
    func fetchMoviePoster(with movieName: String, at openYear: String) async throws -> [Tmdb] {
        sleep(1)
        return [Tmdb.dummyTmdb]
    }
}
```

- 이런 형태로 해주면 서버가 완성되어 있지 않아도 내가 원하는 UI를 계속 구현할 수 있다.
- 그리고 나중에 `DefaultMoviesRepository`로 교체만 해주면 된다.

<img src="https://github.com/hhhan0315/BoxOffice/blob/main/screenshot/CleanArchitecture_3-1.png" width="20%">

