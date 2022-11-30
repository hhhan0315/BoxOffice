# 적용 과정

<img src="https://github.com/hhhan0315/BoxOffice/blob/main/screenshot/CleanArchitecture_2-1.png">

- 앱을 실행했을 경우 첫 화면의 viewDidLoad 상태일 때 예시로 적용 과정을 설명하려고 한다.

## 1. View는 ViewModel의 메서드 호출
- 현재 앱은 UIViewController가 View의 역할을 담당하고 있다.
- ViewModel의 input 메서드 중 하나인 viewDidLoad() 호출

```swift
final class MovieListViewController: UIViewController {
    
    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 생략
        
        viewModel.viewDidLoad()
    }
}
```

## 2. ViewModel은 UseCase를 실행
- UseCase를 실행하고 받은 [Movie]를 이제 화면에 그려질 데이터를 만들기 위해 [MovieListItemViewModel]로 만들어준다.

```swift
final class MovieListViewModel: MovieListViewModelInput, MovieListViewModelOutput {
    private let movieListUseCase: MovieListUseCase
    
    init(movieListUseCase: MovieListUseCase) {
        self.movieListUseCase = movieListUseCase
    }
    
    // MARK: - Input
    
    func viewDidLoad() {
        fetchMovies(with: .daily)
    }
    
    // MARK: - Output
    
    @Published var items: [MovieListItemViewModel] = []
    @Published var loading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var movies: [Movie] = []
    
    private func fetchMovies(with kobisWeekType: KobisWeekType) {
        Task {
            do {
                items.removeAll()
                loading = true
                
                let movies = try await movieListUseCase.execute(with: kobisWeekType)
                let items = movies.map { MovieListItemViewModel(movie: $0) }
                
                self.items = items
                self.movies = movies
                loading = false
            } catch {
                if let networkError = error as? NetworkError {
                    self.errorMessage = networkError.rawValue
                }
            }
        }
    }
}
```

## 3. UseCase는 User와 Repository로부터 데이터를 조합
- 현재 일간, 주간, 주말, 주중 버튼을 통해 정보를 요청할 수 있다.
- 1. 영화진흥위원회 오픈 API 호출 및 [BoxOfficeList] Entity 응답
- 2. BoxOfficeList 데이터의 영화 이름, 개봉연도를 통해 TMDB API 포스터 정보 요청 후 [Tmdb?] Entity 응답
- 3. 두 개의 Entity를 조합해 Movie Entity 생성

```swift
protocol MovieListUseCase {
    func execute(with kobisWeekType: KobisWeekType) async throws -> [Movie]
}

final class DefaultMovieListUseCase: MovieListUseCase {
    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func execute(with kobisWeekType: KobisWeekType) async throws -> [Movie] {
        let boxOfficeLists = try await fetchBoxOfficeLists(with: kobisWeekType)
        let tmdbs = try await fetchTmdbs(with: boxOfficeLists)
        
        var movies: [Movie] = []
        for (index, boxOfficeList) in boxOfficeLists.enumerated() {
            let movie = Movie(boxOfficeList: boxOfficeList, tmdb: tmdbs[index])
            movies.append(movie)
        }
        return movies
    }
    
    private func fetchBoxOfficeLists(with kobisWeekType: KobisWeekType) async throws -> [BoxOfficeList] {
        switch kobisWeekType {
        case .daily:
            return try await moviesRepository.fetchDailyMovieList()
        case .week, .weekend, .weekdays:
            return try await moviesRepository.fetchWeeklyMovieList(with: kobisWeekType)
        }
    }
    
    private func fetchTmdbs(with boxOfficeLists: [BoxOfficeList]) async throws -> [Tmdb?] {
        var tmdbs: [Tmdb?] = []
        
        for boxOfficeList in boxOfficeLists {
            let result = try await moviesRepository.fetchMoviePoster(with: boxOfficeList.movieName, at: String(boxOfficeList.openDate.prefix(4)))
            
            if let tmdbFirst = result.first {
                tmdbs.append(tmdbFirst)
            } else {
                tmdbs.append(nil)
            }
        }
        
        return tmdbs
    }
}
```

## 4. Repository는 Network에서 데이터 가져오기
```swift
extension DefaultMoviesRepository: MoviesRepository {
    func fetchDailyMovieList() async throws -> [BoxOfficeList] {
        let yesterday = Date.yesterday.toString(.yyyyMMdd)
        let dailyMoviesResponseDTO = try await networkService.request(api: KobisAPI.getDailyBoxOfficeList(date: yesterday), dataType: DailyMoviesResponseDTO.self)
        let boxOfficeLists = dailyMoviesResponseDTO.boxOfficeResult.dailyBoxOfficeList.map { $0.toDomain() }
        return boxOfficeLists
    }
}
```

## 5. 정보는 다시 View로 흐른다.
- ViewModel에서 화면에 필요한 데이터가 변경되면 View에서 해당 값을 구독하고 있기 때문에 변화가 일어난다.

```swift
private func bind() {
    viewModel.$items
        .receive(on: DispatchQueue.main)
        .sink { [weak self] _ in
            self?.tableView.reloadData()
        }
        .store(in: &cancellables)
    
    viewModel.$loading
        .receive(on: DispatchQueue.main)
        .sink { [weak self] loading in
            if loading {
                self?.activityIndicatorView.startAnimating()
            } else {
                self?.activityIndicatorView.stopAnimating()
            }
        }
        .store(in: &cancellables)
    
    viewModel.$errorMessage
        .receive(on: DispatchQueue.main)
        .sink { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
        }
        .store(in: &cancellables)
}
```
