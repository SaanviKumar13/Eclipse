//
//  ViewController.swift
//  Eclipse
//
//  Created by user@87 on 28/10/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViewRequestsButton()
    }
    
    private func setupViewRequestsButton() {
        // Create the button
        let viewRequestsButton = UIButton(type: .system)
        viewRequestsButton.setTitle("View Requests", for: .normal)
        viewRequestsButton.setTitleColor(.gray, for: .normal)
        viewRequestsButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        // Add target action for button tap
        viewRequestsButton.addTarget(self, action: #selector(viewRequestsButtonTapped), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(viewRequestsButton)
        
        // Set button constraints
        viewRequestsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewRequestsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewRequestsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func viewRequestsButtonTapped() {
        // Present the RequestsViewController when the button is tapped
        let requestsViewController = RequestsViewController()
        navigationController?.pushViewController(requestsViewController, animated: true)
    }
}
