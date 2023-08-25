//
//  ExtUiView.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 25.08.2023.
//

import UIKit

extension UIView {
    func addTopShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 4
    }
    
    func addLabels(title: String, subtitle: String) {
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 5, width: 130, height: 20))
        titleLabel.text = "\(title)"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let subtitleLabel = UILabel(frame: CGRect(x: 20, y: 25, width: 130, height: 20))
        subtitleLabel.text = "\(subtitle)"
        subtitleLabel.textColor = .lightGray
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
}
