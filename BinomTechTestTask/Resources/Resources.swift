//
//  Resources.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 22.08.2023.
//

import UIKit

enum Resources {
    
    enum StandardImageTitle {
        
        static let profileImage = "profileImage"
        
        enum Buttons {
            static let plus = "plus"
            static let minus = "minus"
            static let location = "location"
            static let circularArrow = "arrow.triangle.turn.up.right.circle"
        }
        
        enum InfoTitle {
            static let wifi = "wifi"
            static let calendar = "calendar"
            static let clock = "clock"
        }
        
    }
    
    enum ConstantsMapView {
        static let buttonSpacing: CGFloat = 15
        static let buttonWidthMultiplier: CGFloat = 0.13
        static let containerTopMargin: CGFloat = 30
        static let containerTrailingMargin: CGFloat = 15
    }
    
    enum ConstantsSheetView {
        static let profileImageWidthMultiplier: CGFloat = 0.2
        static let viewHistoryButtonWidthMultiplier: CGFloat = 0.6
        static let buttonHeight: CGFloat = 50
        
        static let networkDateTimeStackViewSpacing: CGFloat = 20
        static let userDetailsStackViewSpacing: CGFloat = 5
        static let infoActionStackViewSpacing: CGFloat = 25
        static let mainStackViewSpacing: CGFloat = 10
        static let stackViewSpacing: CGFloat = 3
        
        static let nameLabelText = "Илья"
        static let viewHistoryButtonTitle = "Посмотреть историю"
    }
}
