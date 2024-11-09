//
//  LendViewController.swift
//  Eclipse
//
//  Created by admin48 on 09/11/24.
//


import UIKit

class LendView: UIView, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookCell.self, forCellReuseIdentifier: "BookCell") // Register custom cell
        addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // Number of lent books
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        // Configure the cell with lent book data
        cell.configure(with: mockBooks[indexPath.row])
        return cell
    }

//    // Sample data for lent books
//    private let lentBooks: [Book] = [
//        Book(
//            id: "First Term at Malory Towers",
//            title: "@janedoe",
//            author: "malory_towers",
//            genre: "Children", // Genre available for this book
//            description: "A fun children's book.", // Description available for this book
//            price: "₹100", // Price available
//            lender: "@janedoe", // Lender available
//            imageName: "malory_towers", // Image name from the assets
//            daysLeft: "2 Days" // Days left for lending
//        ),
//        Book(
//            id: "Flawed",
//            title: "@sarahj",
//            author: "flawed",
//            genre: "Fiction", // Genre available for this book
//            description: "A dystopian fiction novel.", // Description available for this book
//            price: "₹150", // Price available
//            lender: "@sarahj", // Lender available
//            imageName: "flawed", // Image name from the assets
//            daysLeft: "3 Days" // Days left for lending
//        ),
//        Book(
//            id: "Dune",
//            title: "@johndoe",
//            author: "dune",
//            genre: "Sci-Fi", // Genre available for this book
//            description: "A classic science fiction novel.", // Description available for this book
//            price: "₹200", // Price available
//            lender: "@johndoe", // Lender available
//            imageName: "dune", // Image name from the assets
//            daysLeft: "4 Days" // Days left for lending
//        ),
//        Book(
//            id: "Gone Girl",
//            title: "@janedoe",
//            author: "gone_girl",
//            genre: "Thriller", // Genre available for this book
//            description: "A psychological thriller.", // Description available for this book
//            price: "₹150", // Price available
//            lender: "@janedoe", // Lender available
//            imageName: "gone_girl", // Image name from the assets
//            daysLeft: "3 Days" // Days left for lending
//        )
//    ]

}
