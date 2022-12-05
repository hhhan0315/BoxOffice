//
//  MovieListButtonStackView.swift
//  BoxOffice
//
//  Created by rae on 2022/11/25.
//

import UIKit

protocol MovieListButtonStackViewDelegate: AnyObject {
    func didSelectButton(tag: Int)
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
        button.tag = KobisWeekType.daily.rawValue
        return button
    }()
    
    private let weekButton: UIButton = {
        let button = MovieListMenuButton(title: ButtonTitle.week.rawValue)
        button.tag = KobisWeekType.week.rawValue
        return button
    }()
    
    private let weekendButton: UIButton = {
        let button = MovieListMenuButton(title: ButtonTitle.weekend.rawValue)
        button.tag = KobisWeekType.weekend.rawValue
        return button
    }()
    
    private let weekDaysButton: UIButton = {
        let button = MovieListMenuButton(title: ButtonTitle.weekdays.rawValue)
        button.tag = KobisWeekType.weekdays.rawValue
        return button
    }()
    
    private var buttons: [UIButton] = []
    
    weak var delegate: MovieListButtonStackViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        distribution = .fillEqually
        
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        buttons = [dailyButton, weekButton, weekendButton, weekDaysButton]
        
        let actionHandler: (UIAction) -> Void = { [weak self] action in
            self?.buttons.forEach {
                $0.isSelected = false
            }
            
            guard let button = action.sender as? UIButton else {
                return
            }
            
            button.isSelected = true
            self?.delegate?.didSelectButton(tag: button.tag)
        }
        
        let action = UIAction(handler: actionHandler)
        
        buttons.forEach {
            addArrangedSubview($0)
            $0.addAction(action, for: .touchUpInside)
        }
    }
}
