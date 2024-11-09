//
//  BorrowViewController.swift
//  Eclipse
//
//  Created by admin48 on 09/11/24.
//

import UIKit

    class BorrowView: UIView, UITableViewDelegate, UITableViewDataSource {

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
            return 5 // Number of borrowed books
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
            cell.configure(with: borrowedBooks[indexPath.row])
            return cell
        }

      
           
           
       
private let borrowedBooks: [Book] = [
    Book(
        title: "Gone Girl",
        tags: ["Thriller", "Mystery"],
        rating: 4.5,
        price: "₹150",
        rentersNearby: 5,
        lender: "@janedoe",
        imageName: "gone_girl",
        daysLeft: "3 Days"
    ),
    Book(
        title: "The Devotion of Suspect X",
        tags: ["Mystery", "Thriller"],
        rating: 4.0,
        price: "₹100",
        rentersNearby: 3,
        lender: "@sarahj",
        imageName: "devotion",
        daysLeft: "2 Days"
    ),
    Book(
          id: "Verity",
          title: "@johndoe",
          author: "verity",
          genre: "Thriller", // Genre available for this book
          description: "A psychological thriller.", // Description available for this book
          price: "₹100", // Price available
          lender: "@johndoe", // Lender available
          imageName: "verity", // Image name from the assets
          daysLeft: "2 Days" // Days left for borrowing
      ),
      Book(
          id: "First Term at Malory Towers",
          title: "@janedoe",
          author: "malory_towers",
          genre: "Children", // Genre available for this book
          description: "A fun children's book.", // Description available for this book
          price: "₹100", // Price available
          lender: "@janedoe", // Lender available
          imageName: "malory_towers", // Image name from the assets
          daysLeft: "2 Days" // Days left for borrowing
      ),
      Book(
          id: "Flawed",
          title: "@sarahj",
          author: "flawed",
          genre: "Fiction", // Genre available for this book
          description: "A dystopian fiction novel.", // Description available for this book
          price: "₹150", // Price available
          lender: "@sarahj", // Lender available
          imageName: "flawed", // Image name from the assets
          daysLeft: "3 Days" // Days left for borrowing
      )
  ]
    
    // Add more books with similar structure
}
