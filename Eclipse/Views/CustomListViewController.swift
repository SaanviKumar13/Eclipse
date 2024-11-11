//
//  CustomListViewController.swift
//  Eclipse
//
//  Created by user@87 on 05/11/24.
//

import UIKit

class CustomListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var allBooks: [Book] = []
    var selectedListTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupNavigationBar() {
        title = selectedListTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomListBookCell", for: indexPath) as? CustomBookTableViewCell else {
            return UITableViewCell()
        }

        let book = allBooks[indexPath.row]
        configureCell(cell, with: book)

        return cell
    }

    private func configureCell(_ cell: CustomBookTableViewCell, with book: Book) {
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.author.name
        cell.descriptionLabel.text = book.description
        cell.bookImage.image = book.coverImageURL ?? UIImage(systemName: "book")
        cell.book = book
    }
}
