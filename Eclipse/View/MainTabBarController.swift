//
//  MainTabBarController.swift
//  Eclipse
//
//  Created by admin48 on 12/11/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bookManagementVC = BookManagementViewController()
        let bookManagementNav = UINavigationController(rootViewController: bookManagementVC)
        bookManagementNav.tabBarItem = UITabBarItem(title: "Rent", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        
        // Add other tab bar items here
        
        viewControllers = [bookManagementNav]
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


