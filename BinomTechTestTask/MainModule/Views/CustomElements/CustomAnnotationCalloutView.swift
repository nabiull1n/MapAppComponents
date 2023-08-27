//
//  CustomAnnotationCalloutView.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 25.08.2023.
//

import UIKit

final class CustomAnnotationCalloutView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(width: Int, height: Int) {
        super.init(frame: CGRect(x: 50, y: 50, width: width, height: height))
        backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}
