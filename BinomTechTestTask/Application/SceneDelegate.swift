//
//  SceneDelegate.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 22.08.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let winowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: winowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainViewController()
    }
}
