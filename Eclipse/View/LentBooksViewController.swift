//
//  LentBooksViewController.swift
//  Eclipse
//
//  Created by admin48 on 12/11/24.
//



import UIKit

class LentBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BookCardDelegate {

    // Rent Requests Button
    private let rentRequestsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rent Requests(3)", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Title Label for "Lent Books"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lent Books"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Table View for Lent Books
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BookCard.self, forCellReuseIdentifier: "BookCard") // Register the custom cell
        return tableView
    }()

    // Sample data for lent books
    private let lentBooks: [BookData] = [
        BookData(title: "First Term at Malory Towers", borrowedFrom: nil, lentTo: "@janedoe", price: "₹100", days: "2 Days", coverImage: UIImage(named: "malory_towers")!),
        BookData(title: "Flawed", borrowedFrom: nil, lentTo: "@sarahj", price: "₹150", days: "3 Days", coverImage: UIImage(named: "flawed")!),
        BookData(title: "Dune", borrowedFrom: nil, lentTo: "@johndoe", price: "₹200", days: "4 Days", coverImage: UIImage(named: "dune")!),
        BookData(title: "Gone Girl", borrowedFrom: nil, lentTo: "@janedoe", price: "₹150", days: "3 Days", coverImage: UIImage(named: "gone_girl")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
        setupTableView()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(rentRequestsButton)
        view.addSubview(tableView)

        rentRequestsButton.addTarget(self, action: #selector(rentRequestsButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            rentRequestsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            rentRequestsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc private func rentRequestsButtonTapped() {
        let processingVC = RentalRequestsProcessingViewController()
        navigationController?.pushViewController(processingVC, animated: true)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lentBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCard", for: indexPath) as? BookCard else {
            return UITableViewCell()
        }
        let book = lentBooks[indexPath.row]
        cell.configure(with: book, isLentBook: true)
        cell.delegate = self // Set the delegate
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Adjust the row height if needed
    }

    // MARK: - BookCardDelegate

    func didTapChat(for book: BookData) {
        let chatVC = ChatViewController()
        chatVC.title = "Chat with \(book.lentTo ?? "User")"
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
