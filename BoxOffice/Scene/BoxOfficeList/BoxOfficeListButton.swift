//
//  BoxOfficeListButton.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

final class BoxOfficeListButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .label : .systemBackground
            layer.borderColor = isSelected ? UIColor.label.cgColor : UIColor.lightGray.cgColor
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        titleLabel?.font = .systemFont(ofSize: 17.0, weight: .semibold)
        
        setTitleColor(.lightGray, for: .normal)
        setTitleColor(.systemBackground, for: .selected)
                
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
