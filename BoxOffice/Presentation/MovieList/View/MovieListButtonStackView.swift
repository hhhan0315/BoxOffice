//
//  MovieListButtonStackView.swift
//  BoxOffice
//
//  Created by rae on 2022/11/25.
//

import UIKit

protocol MovieListButtonStackViewDelegate: AnyObject {
    func didSelectButton(title: String)
}

final class MovieListButtonStackView: UIStackView {
    
    enum ButtonTitle: String {
        case daily = "일별"
        case week = "주간"
        case weekend = "주말"
        case weekdays = "주중"
    }
    
    private let dailyButton: UIButton = {
        let button = MovieListMenuButton(title: ButtonTitle.daily.rawValue)
        button.isSelected = true
        return button
    }()
    
    private let weekButton: UIButton = {
        let button = MovieListMenuButton(title: ButtonTitle.week.rawValue)
        return button
    }()
    
    private let weekendButton: UIButton = {
        let button = MovieListMenuButton(title: ButtonTitle.weekend.rawValue)
        return button
    }()
    
    private let weekDaysButton: UIButton = {
        let button = MovieListMenuButton(title: ButtonTitle.weekdays.rawValue)
        return button
    }()
    
    private var buttons: [UIButton] = []
    
    weak var delegate: MovieListButtonStackViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttons = [dailyButton, weekButton, weekendButton, weekDaysButton]
        
        buttons.forEach {
            addArrangedSubview($0)
            $0.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
        
        axis = .horizontal
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton(_ button: UIButton) {
        buttons.forEach {
            $0.isSelected = false
        }
        
        button.isSelected = true
        
        delegate?.didSelectButton(title: button.title(for: .normal) ?? "")
    }
}
