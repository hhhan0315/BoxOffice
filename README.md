# BoxOffice
영화진흥위원회 오픈 API와 TMDB(The Movie Database) API를 활용한 박스오피스 앱

> iOS 13.0

## 기술 정보

- 화면 구현 : UIKit
- 네트워킹 : URLSession
- 비동기 프로그래밍 : RxSwift
- 디자인 패턴 : ReactorKit

## 구현 내용

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
