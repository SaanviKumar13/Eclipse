//
//  RentersNearbyViewController.swift
//  Eclipse
//
//  Created by admin48 on 17/11/24.
//

import UIKit

class RentersNearbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    
    // Sample data for renters
    private var renters = [
        ("John Doe", 2.0, 40, UIImage(named: "profile")!),
        ("Jane Riviera", 2.5, 50, UIImage(named: "profile")!),
        ("Roderick Usher", 3.0, 35, UIImage(named: "profile")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTitleLabel()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        // Back button
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        backButton.tintColor = .systemBlue
        navigationItem.leftBarButtonItem = backButton
        
        // Title
        navigationItem.title = "Johnathan Cahn"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Renters Near You"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .systemGray5
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
       
    }
    private let separatorLine: UIView = {
            let line = UIView()
            line.backgroundColor = .systemGray5
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return renters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let renter = renters[indexPath.row]
        cell.configure(name: renter.0, distance: renter.1, price: Double(renter.2), profileImage: renter.3)
        cell.delegate = self
        return cell
    }
}
extension RentersNearbyViewController: NearbyRentersCellDelegate {
    func requestRentTapped(for cell: CustomCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let renter = renters[indexPath.row]
        
        let alertController = UIAlertController(
            title: "Confirm Rental",
            message: "Are you sure you want to rent \(renter.0)'s book?",
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            let confirmationAlert = UIAlertController(
                title: "Booking Confirmed",
                message: "Your booking for \(renter.0)'s book is confirmed.",
                preferredStyle: .alert
            )
            confirmationAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(confirmationAlert, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

