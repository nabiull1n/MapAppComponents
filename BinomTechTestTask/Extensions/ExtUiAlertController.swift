//
//  ExtUiAlertController.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 25.08.2023.
//

import UIKit

extension UIAlertController {
    static func createLocationDisabledAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Геолокация отключена",
                                      message: "Для использования геолокации разрешите доступ в настройках.",
                                      preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        return alert
    }
}
