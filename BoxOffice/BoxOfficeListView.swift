//
//  BoxOfficeListView.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

final class BoxOfficeListView: UIView {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BoxOfficeListTableViewCell.self, forCellReuseIdentifier: BoxOfficeListTableViewCell.identifier)
//        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
        ])
    }
}

extension BoxOfficeListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeListTableViewCell.identifier, for: indexPath) as? BoxOfficeListTableViewCell else {
            return .init()
        }
        
        return cell
    }
}

extension BoxOfficeListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
