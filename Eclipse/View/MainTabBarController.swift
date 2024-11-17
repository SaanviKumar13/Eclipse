//
//  MainTabBarController.swift
//  Eclipse
//
//  Created by admin48 on 12/11/24.
//

//import UIKit
//
//class MainTabBarController: UITabBarController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let bookManagementVC = BookManagementViewController()
//        let bookManagementNav = UINavigationController(rootViewController: bookManagementVC)
//        bookManagementNav.tabBarItem = UITabBarItem(title: "Rent", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
//        
//        // Add other tab bar items here
//        
//        viewControllers = [bookManagementNav]
//    }
//}
//
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Book Management Tab
        let bookManagementVC = BookManagementViewController()
        let bookManagementNav = UINavigationController(rootViewController: bookManagementVC)
        bookManagementNav.tabBarItem = UITabBarItem(title: "Rent", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        
        // Rental Requests Tab
//        let rentalRequestsVC = RentalRequestsProcessingViewController()
//        let rentalRequestsNav = UINavigationController(rootViewController: rentalRequestsVC)
//        rentalRequestsNav.tabBarItem = UITabBarItem(title: "Requests", image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book.fill"))

        // Add additional tabs if necessary

        viewControllers = [bookManagementNav]  // Add more tabs if needed
    }
}
