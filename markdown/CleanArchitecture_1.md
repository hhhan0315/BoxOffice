# MVVM 적용 이유
- 기존 프로젝트에서는 MVC를 활용해 구현했었다.
- MVC로 구현한 프로젝트에서 최대한 MVC를 분리해줬어도 ViewController에서 네트워크를 통해 객체를 가져오거나 CoreData에서 저장된 데이터를 가져오거나 하는 부분을 구현해서 사용했었다.
- 그러다보니까 해당 ViewController가 가지고 있는 해당 메서드들을 테스트하기 어려웠다.
- 기존의 Massive View Controller를 해체하면서 코드가 간단해졌다고 느꼈지만 다른 분들이 봤을 때 해당 파일 자체를 들어가봐야 역할을 알 수 있었고 역할과 책임이 모호하게 분리되어져 있다는 생각이 들어서 다른 구조를 채택해보려고 했다.
- 또한 해당 구조를 사용하면서 협업하게 되는 경우 코드의 흐름과 방향성을 파악하기에 쉽지 않을까 생각했다.

## Clean Architecture 적용 이유
- MVVM을 기존에 구현했을 때 단지 ViewModel에서 네트워크를 통해 데이터를 가져오고 객체로 만들었다면 ViewController에서 해당 변수를 구독하고 있어서 변화가 생기면 UI를 업데이트하는 방법으로 구현했다.
- 이렇게 구현했을 때 단지 ViewController에 있던 비즈니스 로직 함수를 ViewModel로만 이동시키고 해당 ViewModel의 테스트만 진행할 수 있어서 문제 없었다.
- 하지만 만약 기능적으로 추가할 기능이 많아진다면 ViewModel에서의 코드의 양이 많아지는 문제가 발생할 수 있을 것이라고 생각했으며 이러한 문제를 해결하기 위해 아키텍쳐에 대한 공부가 필요하다고 생각했다.

# 설명
<img src="https://github.com/hhhan0315/BoxOffice/blob/main/screenshot/CleanArchitecture_1.png">
- 그림 링크 : https://jeonyeohun.tistory.com/305
- UI, API, DB 부분은 단위 테스트할 수 없는 영역이다.
- UI는 UIViewController가 담당한다.

<br>

- Presentation
    - 화면에 필요한 데이터 담당
    - ViewModel
- Domain
    - 비즈니스 로직 및 해당 비즈니스 로직에 의해 영향 받는 모델들
    - UseCase, Entity
- Data
    - 외부에서 데이터를 가져오는 역할 (네트워크 등)
    - Repository : 외부의 데이터를 가져오는 역할

<img src="https://github.com/hhhan0315/BoxOffice/blob/main/screenshot/CleanArchitecture_2.png">
- 그림 링크 : https://tigi44.github.io/ios/iOS,-Swift-Clean-Architecture-with-MVVM-DesignPattern-on-iOS/
- 핵심은 `내부에 있는 계층이 외부에 있는 계층을 알지 못한다`.

