//
//  CustomButton.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 22.08.2023.
//

import UIKit

final class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    init(title: String?){
        super.init(frame: .zero)
        guard let title = title else { return }
        
        setImage(UIImage(systemName: title), for: .normal)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
}
