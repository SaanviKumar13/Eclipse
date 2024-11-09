//
//  SceneDelegate.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.




import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create an instance of MainViewController
        let mainViewController = MainViewController()
        
        // Embed MainViewController in a UINavigationController
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        // Set up the window
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
