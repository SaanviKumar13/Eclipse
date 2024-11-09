//
//  RequestsViewController.swift
//  Eclipse
//
//  Created by admin48 on 09/11/24.
//


import UIKit

class RequestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Sample data structure to represent each book request
    struct BookRequest {
        let title: String
        let renter: String
        let profileImage: UIImage
        let price: String
        let days: String
        let bookCover: UIImage
    }
    
    // Sample data
    let requests = [
        BookRequest(title: "The Priory Of The Orange Tree", renter: "Jane Doe", profileImage: UIImage(named: "profile")!, price: "₹60", days: "2 Days", bookCover: UIImage(named: "book1")!),
        BookRequest(title: "Six Of Crows", renter: "Peter Parker", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "book2")!),
        BookRequest(title: "Tuesday Mooney Talks to Ghosts", renter: "Caroline Davis", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "book3")!)
    ]
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View setup
        view.backgroundColor = .white
        navigationItem.title = "Rent Requests"
        
        // TableView setup
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RequestTableViewCell.self, forCellReuseIdentifier: "RequestTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 120
        view.addSubview(tableView)
        
        // Constraints for tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell", for: indexPath) as? RequestTableViewCell else {
            return UITableViewCell()
        }
        let request = requests[indexPath.row]
        cell.configure(with: request)
        return cell
    }
}
