//
//  SceneDelegate.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let splashVC = SplashViewController()

        let tabBarController = setupTabBarController()

        let navigationController = UINavigationController(rootViewController: splashVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            navigationController.setViewControllers([tabBarController], animated: true)
        }
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setupTabBarController() -> UITabBarController {
        let rentHomeVC = RentHomeViewController()
        rentHomeVC.tabBarItem = UITabBarItem(title: "Rent", image: UIImage(systemName: "building.2"), tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: rentHomeVC)
        ]
        
        return tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
