//
//  AuthorBooksViewController.swift
//  Eclipse
//
//  Created by user@87 on 16/11/24.
//

import UIKit

class AuthorBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var author: Author?
    var books: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        if let author = author {
            books = mockBooks.filter { $0.author.authorID == author.authorID }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "authorBookCell", for: indexPath) as? AuthorBookTableViewCell else {
            return UITableViewCell()
        }

        let book = books[indexPath.row]
        cell.title.text = book.title
        cell.rating.text = "Rating: \(book.rating)"
        cell.seriesInfo.text = book.seriesInfo?.seriesName ?? "Standalone Book"
        cell.bookImage.image = book.coverImageURL ?? UIImage(named: "placeholder_image")

        // Add bookmark button action
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedBook = books[indexPath.row]
        let bookVC = BookViewController(book: selectedBook)
        navigationController?.pushViewController(bookVC, animated: true)
    }

    @objc private func bookmarkButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showBookmark", sender: sender)
    }
}
