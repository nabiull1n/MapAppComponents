//
//  CustomImage.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 22.08.2023.
//

import UIKit

final class CustomImage: UIImageView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(name: String?){
        super.init(frame: .zero)
        guard let name = name else { return }
        
        image = UIImage(named: "\(name)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.blue.cgColor
    }
}
