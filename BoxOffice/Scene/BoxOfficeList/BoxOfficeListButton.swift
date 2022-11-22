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
            layer.borderColor = isSelected ? UIColor.label.cgColor : UIColor.lightGray.cgColor
            isUserInteractionEnabled = isSelected ? false : true
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.systemGray3, for: .normal)
        setTitleColor(.white, for: .selected)
        
        titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
