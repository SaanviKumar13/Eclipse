//
//  MainTabBarController.swift
//  Eclipse
//
//  Created by admin48 on 12/11/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        configureTabBar()
        super.viewDidLoad()
        
    }

    private func configureTabBar() {
        let homeNav = createNavController(
            viewController: ViewController(),
            title: "Home",
            iconName: "house.fill",
            tag: 0
        )
        
        let exploreNav = createNavController(
            viewController: ExploreViewController(),
            title: "Explore",
            iconName: "magnifyingglass",
            tag: 1
        )
        
        let rentNav = createNavController(
            viewController: HomeViewController(),
            title: "Rent",
            iconName: "cart.fill",
            tag: 2
        )

        let libraryNav = createNavController(
            viewController: LibraryViewController(),
            title: "Library",
            iconName: "book.fill",
            tag: 3
        )
        
        let bookManagementVC = HomeViewController()
        let bookManagementNav = UINavigationController(rootViewController: bookManagementVC)
        bookManagementNav.tabBarItem = UITabBarItem(title: "Rent", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))

        viewControllers = [homeNav,exploreNav, rentNav,  libraryNav]
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
    }

    private func createNavController(viewController: UIViewController, title: String, iconName: String, tag: Int) -> UINavigationController {
        viewController.view.backgroundColor = .white
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: iconName), tag: tag)
        viewController.navigationItem.title = title
        viewController.navigationItem.largeTitleDisplayMode = .always
                viewController.navigationController?.navigationBar.prefersLargeTitles = true
        return navController
    }
}
