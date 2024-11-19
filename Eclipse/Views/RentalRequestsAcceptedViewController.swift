//
//  RentalRequestsAcceptViewController.swift
//  Eclipse
//
//  Created by admin48 on 12/11/24.
//



import UIKit

class RentalRequestsAcceptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Sample data structure to represent each book request
    struct BookRequest {
        let title: String
        let renter: String
        let profileImage: UIImage
        let price: String
        let days: String
        let bookCover: UIImage
        let status: String
    }
    
    // Sample data
    let requests = [
        BookRequest(title: "The Priory Of The Orange Tree", renter: "Jane Doe", profileImage: UIImage(named: "profile")!, price: "₹60", days: "2 Days", bookCover: UIImage(named: "priory_of_the_orange_tree")!, status: "Accepted"),
        BookRequest(title: "Six Of Crows", renter: "Peter Parker", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "six_of_crows")!, status: "Under Review"),
        BookRequest(title: "Tuesday Mooney Talks to Ghosts", renter: "Caroline Davis", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "tuesday_mooney_talks_to_ghosts")!, status: "Rejected")
    ]
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View setup
        view.backgroundColor = .white
        setupNavigationBar()
        
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
    
    private func setupNavigationBar() {
        // Create a label with the desired text attributes
        let titleLabel = UILabel()
        titleLabel.text = "Rent Requests"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        
        // Set the label as the navigation item's titleView
        navigationItem.titleView = titleLabel
        
        // Ensure the title is centered
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.largeTitleDisplayMode = .never
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
        cell.configure(with: request, status: request.status)
        cell.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return cell
    }
        
    @objc private func profileButtonTapped() {
        let booksViewController = RentersProfileViewController()

        // Customize back button with chevron
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(systemName: "chevron.left")
        backButton.tintColor = UIColor.black
        booksViewController.navigationItem.leftBarButtonItem = backButton
        
        // Push the books view controller
        navigationController?.pushViewController(booksViewController, animated: true)
    }
}
