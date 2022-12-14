//
//  MoviePosterNewLabelView.swift
//  BoxOffice
//
//  Created by rae on 2022/11/22.
//

import UIKit

final class MoviePosterNewLabelView: UIView {
    
    private let newLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        layer.opacity = 0.8
        
        isHidden = true
        
        setupNewLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNewLabel() {
        addSubview(newLabel)
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4.0),
            newLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0),
            newLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.0),
            newLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4.0),
        ])
    }
}
