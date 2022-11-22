//
//  PosterNewLabelView.swift
//  BoxOffice
//
//  Created by rae on 2022/11/22.
//

import UIKit

final class PosterNewLabelView: UIView {
    
    private let posterNewLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        layer.opacity = 0.7
        
        setupPosterNewLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPosterNewLabel() {
        addSubview(posterNewLabel)
        posterNewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterNewLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4.0),
            posterNewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            posterNewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.0),
            posterNewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
        ])
    }
}
