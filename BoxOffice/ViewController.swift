//
//  ViewController.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

final class ViewController: UIViewController {
    
    private let mainView = HomeView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
}

