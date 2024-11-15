//
//  RentalRequestsProcessingViewController.swift
//  Eclipse
//
//  Created by admin48 on 12/11/24.
//




//class RentalRequestsProcessingViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
//   
//   // Sample data structure to represent each book request
//   struct BookRequest {
//        let title: String
//       let renter: String
//        let profileImage: UIImage
//       let price: String
//       let days: String
//        let bookCover: UIImage
//    }
//    
//   // Sample data
//    let requests = [
//        BookRequest(title: "The Priory Of The Orange Tree", renter: "Jane Doe", profileImage: UIImage(named: "profile")!, price: "₹60", days: "2 Days", bookCover: UIImage(named: "book1")!),
//        BookRequest(title: "Six Of Crows", renter: "Peter Parker", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "book2")!),
//        BookRequest(title: "Tuesday Mooney Talks to Ghosts", renter: "Caroline Davis", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "book3")!)
//    ]
//    
//    private let tableView = UITableView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // View setup
//        view.backgroundColor = .white
//        navigationItem.title = "Rent Requests"
//        
//        // TableView setup
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(RequestTableViewCell.self, forCellReuseIdentifier: "RequestTableViewCell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.rowHeight = 120
//        view.addSubview(tableView)
//        
//        // Constraints for tableView
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    // MARK: - UITableViewDataSource
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return requests.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell", for: indexPath) as? RequestTableViewCell else {
//            return UITableViewCell()
//        }
//        let request = requests[indexPath.row]
//        cell.configure(with: request, status: <#String#>)
//        return cell
//    }
//}


//class RentalRequestsProcessingViewController: UIViewController {
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .systemGroupedBackground
//        tableView.separatorStyle = .none
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//    
//    private var requests: [RentalRequest] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        setupNavigationBar()
//        setupTableView()
//        loadRequests()
//    }
//    
//    private func setupViews() {
//        view.backgroundColor = .systemGroupedBackground
//        view.addSubview(tableView)
//        
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    private func setupNavigationBar() {
//        title = "Rent Requests"
//        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "chevron.left"),
//            style: .plain,
//            target: self,
//            action: #selector(backButtonTapped)
//        )
//    }
//    
//    private func setupTableView() {
//        tableView.register(RequestsProcessingTableViewCell.self, forCellReuseIdentifier: "RequestCell")
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//    
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    private func loadRequests() {
//        // Simulated data loading
//        requests = [
//            RentalRequest(
//                bookImage: UIImage(named: "priory"),
//                bookTitle: "The Priory Of The Orange Tree",
//                userImage: UIImage(named: "user1"),
//                userName: "Jane Doe",
//                price: 0,
//                duration: 0,
//                status: .rejected
//            ),
//            RentalRequest(
//                bookImage: UIImage(named: "crows"),
//                bookTitle: "Six Of Crows",
//                userImage: UIImage(named: "user2"),
//                userName: "Peter Parker",
//                price: 300,
//                duration: 10,
//                status: .underReview
//            ),
//            RentalRequest(
//                bookImage: UIImage(named: "tuesday"),
//                bookTitle: "Tuesday Mooney Talks to Ghosts",
//                userImage: UIImage(named: "user3"),
//                userName: "Caroline Davis",
//                price: 0,
//                duration: 0,
//                status: .accepted
//            )
//        ]
//        tableView.reloadData()
//    }
//}
//
//// MARK: - UITableView DataSource & Delegate
//extension RentalRequestsProcessingViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return requests.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as? RequestsProcessingTableViewCell else {
//            return UITableViewCell()
//        }
//        cell.configure(with: requests[indexPath.row], status: request.status.rawValue)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 160
//    }
//}
//
//// MARK: - Models
//struct RentalRequest {
//    let bookImage: UIImage?
//    let bookTitle: String
//    let userImage: UIImage?
//    let userName: String
//    let price: Int
//    let duration: Int
//    let status: RentalStatus
//}
//
//enum RentalStatus: String {
//    case rejected = "Rejected"
//    case underReview = "Under Review"
//    case accepted = "Accepted"
//}
//
//
//
//import UIKit
//
//class RentalRequestsProcessingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    // Assuming BookData is the data model you use instead of BookRequest
//    struct BookData {
//        let title: String
//        let renter: String
//        let profileImage: UIImage
//        let price: String
//        let days: String
//        let bookCover: UIImage
//        let status: String
//    }
//
//    // Sample data
//    let requests = [
//        BookData(title: "The Priory Of The Orange Tree", renter: "Jane Doe", profileImage: UIImage(named: "profile")!, price: "₹60", days: "2 Days", bookCover: UIImage(named: "book1")!, status: "Accepted"),
//        BookData(title: "Six Of Crows", renter: "Peter Parker", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "book2")!, status: "Under Review"),
//        BookData(title: "Tuesday Mooney Talks to Ghosts", renter: "Caroline Davis", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "book3")!, status: "Rejected")
//    ]
//    
//    private let tableView = UITableView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // View setup
//        view.backgroundColor = .white
//        navigationItem.title = "Rent Requests"
//
//        // TableView setup
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(RequestTableViewCell.self, forCellReuseIdentifier: "RequestTableViewCell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.rowHeight = 120
//        view.addSubview(tableView)
//
//        // Constraints for tableView
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    // MARK: - UITableViewDataSource
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return requests.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell", for: indexPath) as? RequestTableViewCell else {
//            return UITableViewCell()
//        }
//        let request = requests[indexPath.row]
//        cell.configure(with: request, status: request.status)  // Pass status from data
//        return cell
//    }
//}
import UIKit

class RentalRequestsProcessingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct BookRequests {
        let title: String
        let renter: String
        let profileImage: UIImage
        let price: String
        let days: String
        let bookCover: UIImage
        let status: String
    }

    let requests = [
        BookRequests(title: "The Priory Of The Orange Tree", renter: "Jane Doe", profileImage: UIImage(named: "profile")!, price: "₹60", days: "2 Days", bookCover: UIImage(named: "book1")!, status: "Accepted"),
        BookRequests(title: "Six Of Crows", renter: "Peter Parker", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "book2")!, status: "Under Review"),
        BookRequests(title: "Tuesday Mooney Talks to Ghosts", renter: "Caroline Davis", profileImage: UIImage(named: "profile")!, price: "₹300", days: "10 Days", bookCover: UIImage(named: "book3")!, status: "Rejected")
    ]
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Rent Requests"

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RequestssTableViewCell.self, forCellReuseIdentifier: "RequestsTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 120
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestsTableViewCell", for: indexPath) as? RequestssTableViewCell else {
            return UITableViewCell()
        }
        let request = requests[indexPath.row]  // Rename to 'request' to avoid conflict
        cell.configure(with: request, status: request.status)  // Pass the status explicitly
        return cell
    }

    }

