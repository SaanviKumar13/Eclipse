//
//  ViewController.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.
//

//import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        setupViewRequestsButton()
//    }
//    
//    private func setupViewRequestsButton() {
//        // Create the button
//        let viewRequestsButton = UIButton(type: .system)
//        viewRequestsButton.setTitle("View Requests", for: .normal)
//        viewRequestsButton.setTitleColor(.gray, for: .normal)
//        viewRequestsButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//        
//        // Add target action for button tap
//        viewRequestsButton.addTarget(self, action: #selector(viewRequestsButtonTapped), for: .touchUpInside)
//        
//        // Add the button to the view
//        view.addSubview(viewRequestsButton)
//        
//        // Set button constraints
//        viewRequestsButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            viewRequestsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            viewRequestsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
//    @objc private func viewRequestsButtonTapped() {
//        // Present the RequestsViewController when the button is tapped
//        let requestsViewController = RequestsViewController()
//        navigationController?.pushViewController(requestsViewController, animated: true)
//    }
//}
import UIKit

class ViewController: UIViewController {

    // Called when the view has loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the initial view controller appearance or state
        view.backgroundColor = .white
        
        // Additional setup code goes here
    }
    
    // Called when the view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Code to configure the view each time it appears
    }
    
    // Called when the view has appeared on the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Code for animations or fetching data once the view is on screen
    }
    
    // Called when the view is about to disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Code to save state or cleanup as view goes away
    }
    
    // Called when the view has disappeared
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Cleanup code after the view has disappeared
    }
}
