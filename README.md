# BoxOffice
영화진흥위원회 오픈 API와 TMDB(The Movie Database) API를 활용한 박스오피스 앱

> iOS 13.0

## 기술 정보

- 화면 구현 : UIKit
- 네트워킹 : URLSession
- 비동기 프로그래밍 : RxSwift
- 디자인 패턴 : ReactorKit

## 기능

### 1. 박스오피스

<img src="https://github.com/hhhan0315/BoxOffice/blob/main/screenshot/info1.png" width="200"></img>

- 초기 실행시 일별 박스오피스를 불러옵니다.
- 상단의 버튼들을 통해 전환할 수 있습니다.
- 영화를 선택할 경우 영화 세부 정보로 이동합니다.

### 2. 영화 세부 정보

<img src="https://github.com/hhhan0315/BoxOffice/blob/main/screenshot/info2.png" width="200"></img>

- 선택한 영화의 세부 정보를 보여줍니다.
- 줄거리의 더보기를 선택할 경우 전체 내용이 나타납니다.
- 리뷰 작성 버튼을 선택할 경우 리뷰 작성으로 이동합니다.

### 3. 리뷰 작성

<img src="https://github.com/hhhan0315/BoxOffice/blob/main/screenshot/info3.png" width="200"></img>

- 해당 영화의 리뷰를 작성할 수 있습니다.
- 별점, 아이디, 내용이 존재해야하며 형식에 맞는 비밀번호를 작성해야 확인 버튼이 활성화됩니다.
- 확인 버튼을 선택할 경우 영화 세부 정보로 이동하며 리뷰 내용을 불러옵니다.

## 구현 내용

### 1. ReactorKit

- ReactorKit이란 단방향 앱을 위한 프레임워크입니다.
- 사용해보니까 과거에 MVVM 패턴을 사용하면서 ViewModel에 input, output 모델링을 적용한 것과 비슷한 느낌입니다.

```swift
// 제가 생각하는 ReactorKit의 장점입니다.
// 박스오피스 화면 중 버튼을 눌렀을 경우 동작하는 예시입니다.

private func setupButtonDidTap(with kobisWeekType: KobisWeekType) -> Observable<Mutation> {
    return Observable.concat([
        // 배열을 초기화합니다.
        Observable.just(Mutation.requestBoxOfficeLists([])),
        
        // 로딩을 시작합니다. (UIActivityIndicator의 isAnimating과 연결)
        Observable.just(Mutation.setLoading(true)),
        
        // 클릭한 버튼을 전달합니다. (버튼 UI 변경)
        Observable.just(Mutation.setButtonDidSelected(kobisWeekType)),
        
        // 네트워크 비동기 처리
        self.setupBoxOfficeListResponse(with: kobisWeekType),
        
        // 로딩을 종료합니다.
        Observable.just(Mutation.setLoading(false))
    ])
    .catch { error in
            .concat([
                // 에러메시지를 전달합니다.
                Observable.just(Mutation.showAlertMessage(error as? NetworkError)),
                // 로딩을 종료합니다.
                Observable.just(Mutation.setLoading(false))
            ])
    }
}
```

- 위의 예시처럼 버튼을 클릭한 경우 처리과정을 직관적으로 확인할 수 있고 이해하기 쉬웠습니다.
- 상태값을 RxCocoa를 활용해 연결해놓을 수 있어서 과거에 상태값에 따라 분기처리로 구현한 것보다 깔끔해졌습니다.
- RxSwift와 MVVM을 사용할 경우 개발자마다 다른데 ReactorKit을 사용하는 경우 동일하게 구현할 수 있어서 유지보수에도 유리하다고 생각합니다.

### 2. 연속적인 네트워크 요청

- 영화진흥위원회 API에는 포스터 정보가 존재하지 않았습니다. 그래서 다른 API의 호출도 필요했습니다.
- 초기 구현
1. 박스오피스 요청
2. 박스오피스 리스트 내의 영화 상세 정보 요청
3. 영화 상세 정보의 영어 제목과 TMDB API 활용한 포스터, 줄거리 요청
4. 이미지 요청
- 이런 과정을 첫 화면이 나타날 때 모두 요청하다보니까 사용자 경험이 떨어지고 기다리는 시간이 너무 길어졌습니다.
<br>

- 현재 구현
1. 박스오피스 요청 (응답 후 이미지 부분 제외하고 UI 표시)
2. 각 Cell에 reactor를 구현해주면서 박스오피스 리스트 내의 영화 한글 제목과 TMDB API 활용해 포스터 요청
3. 이미지 요청
- 시간이 오래 걸리는 이미지 요청을 제외하고 제목과 정보들을 먼저 나타내주고 각 셀마다 이미지 요청을 동작하도록 수정했습니다.
- 기다리는 시간이 훨씬 줄어들었습니다.

### 3. ReactorKit 상태값의 존재 장점

<img src="https://github.com/hhhan0315/BoxOffice/blob/main/screenshot/feature1.png" width="200"></img>

- 해당 이미지의 주황색 부분을 구현하려고 할 때의 예시입니다.
- API 응답을 받았을 때 보통 데이터는 우리가 UI에서 나타내야할 모습과 다릅니다. 그래서 우리가 필요로 하는 모습으로 바꿔줘야합니다.
- 기존에는 CellViewModel을 하나 더 만들어서 구현해줬습니다. 비슷하게 Cell, CellReactor를 구현해주면 됩니다.

```swift
// 생략된 코드가 있습니다.
final class MovieCollectionViewCellReactor: Reactor {
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        case requestTmdb(Tmdb)
    }
    
    struct State {
        // 우리가 Cell에서 보여줘야할 상태값입니다.
        
        var rank: String?
        var rankInten: String?
        var isRankIntenUp: Bool = false
        var isNew: Bool = false
        var movieName: String?
        var openDate: String?
        var audienceAcc: String?
        
        var posterPath: String?
    }
    
    private let boxOfficeList: BoxOfficeList
    var initialState: State = State()
    
    init(boxOfficeList: BoxOfficeList) {
        self.boxOfficeList = boxOfficeList
        self.initialState = State(
            // 그대로 사용할 것은 그대로 사용하고 변경할 필요가 있으면 변경합니다.
            
            rank: boxOfficeList.rank,
            rankInten: self.setupRankInten(with: boxOfficeList),
            isRankIntenUp: self.setupIsRankIntenUp(with: boxOfficeList),
            isNew: boxOfficeList.rankOldAndNew == "NEW" ? true : false,
            movieName: boxOfficeList.movieName,
            openDate: "\(boxOfficeList.openDate.replacingOccurrences(of: "-", with: ".")) 개봉",
            audienceAcc: self.setupAudienceAcc(with: boxOfficeList)
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        
        // Cell이 생성될 경우 해당 메서드를 바로 실행합니다.
        // 영화 한글 이름과 TMDB API를 요청 후 포스터 정보를 응답 받습니다.
        
        case .viewDidLoad:
            return TmdbRepository().getMovieTmdbResponse(
                movieName: self.boxOfficeList.movieName
            )
            .compactMap { $0.results.first?.toDomain() }
            .map { Mutation.requestTmdb($0) }
        }
    }
}
```
