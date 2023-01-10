//
//  ReviewViewController.swift
//  BoxOffice
//
//  Created by rae on 2023/01/10.
//

import UIKit

import ReactorKit

final class ReviewViewController: UIViewController, View {
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: ReviewReactor) {
        // Action
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe { _ in
                print("확인")
                // MovieCode를 가지고 리뷰 목록 저장 후 dismiss
            }
            .disposed(by: disposeBag)
        
        // State
        
        // View
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupViews()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "리뷰 작성"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: nil, action: nil)
        
        
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
    }
}

