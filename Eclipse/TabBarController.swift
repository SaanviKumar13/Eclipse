//
//  TabBarController.swift
//  Eclipse
//
//  Created by user@87 on 09/11/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }

    private func configureTabBar() {
        let homeNav = createNavController(
            viewController: ViewController(),
            title: "Home",
            iconName: "house.fill",
            tag: 0
        )

        let libraryNav = createNavController(
            viewController: LibraryViewController(),
            title: "Library",
            iconName: "book.fill",
            tag: 1
        )

        viewControllers = [homeNav, libraryNav]
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
