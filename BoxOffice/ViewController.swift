//
//  ViewController.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

final class ViewController: UIViewController {
    
    private let mainView = BoxOfficeListView()
    
    private let apiService = APIService()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Box Office"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return
        }
        
        let dateString = dateFormatter.string(from: yesterday)
        
//        apiService.request(api: .getDailyBoxOfficeList(date: dateString), dataType: DailyBoxOfficeListResponse.self) { [weak self] result in
//            switch result {
//            case .success(let dailyBoxOfficeListResponse):
//                print(dailyBoxOfficeListResponse)
//            case .failure(let apiError):
//                print(apiError.rawValue)
//            }
//        }
    }
}

