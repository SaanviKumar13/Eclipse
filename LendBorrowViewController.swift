//
//  LendBorrowViewController.swift
//  Eclipse
//
//  Created by admin48 on 09/11/24.
//

//import UIKit
//
//class LendBorrowViewController: UIViewController {
//
//    // Segmented Control and TableView Outlets
//    private let segmentedControl: UISegmentedControl = {
//        let control = UISegmentedControl(items: ["Lend", "Borrow"])
//        control.selectedSegmentIndex = 0
//        control.translatesAutoresizingMaskIntoConstraints = false
//        control.addTarget(LendBorrowViewController.self, action: #selector(segmentChanged), for: .valueChanged)
//        return control
//    }()
//    
//    private let viewRequestsButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("View Requests(3)", for: .normal)
//        button.setTitleColor(.gray, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(LendBorrowViewController.self, action: #selector(viewRequestsTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(BookCell.self, forCellReuseIdentifier: "BookCell")
//        table.translatesAutoresizingMaskIntoConstraints = false
//        return table
//    }()
//    
//    private var books: [Book] = [] // Define your Book model elsewhere
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        setupViews()
//        setupConstraints()
//        loadBooks(for: segmentedControl.selectedSegmentIndex)
//    }
//    
//    private func setupViews() {
//        view.addSubview(segmentedControl)
//        view.addSubview(viewRequestsButton)
//        view.addSubview(tableView)
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            viewRequestsButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
//            viewRequestsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            tableView.topAnchor.constraint(equalTo: viewRequestsButton.bottomAnchor, constant: 8),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    @objc private func segmentChanged() {
//        loadBooks(for: segmentedControl.selectedSegmentIndex)
//        tableView.reloadData()
//    }
//    
//    @objc private func viewRequestsTapped() {
//        // Navigate to Requests screen
//        let requestsVC = RequestsViewController()
//        navigationController?.pushViewController(requestsVC, animated: true)
//    }
//    
//    private func loadBooks(for segment: Int) {
//        // Load data for "Lend" or "Borrow" based on segment index
//        // Replace with actual data fetching logic
//        books = segment == 0 ? getLendBooks() : getBorrowBooks()
//        tableView.reloadData()
//    }
//    
//    private func getLendBooks() -> [Book] {
//        // Provide sample data for Lend
//        return [/* Populate with Book instances */]
//    }
//    
//    private func getBorrowBooks() -> [Book] {
//        // Provide sample data for Borrow
//        return [/* Populate with Book instances */]
//    }
//}
//
//extension LendBorrowViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return books.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {
//            return UITableViewCell()
//        }
//        cell.configure(with: books[indexPath.row])
//        return cell
//    }
//}
