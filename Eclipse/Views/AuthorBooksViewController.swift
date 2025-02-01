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
    var books: [BookF] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        // Fetch books for the specific author
        if let author = author {
            fetchBooksByAuthor(authorName: author.name)
        }
    }

    /// Fetch books by the given author using the Google Books API
    private func fetchBooksByAuthor(authorName: String) {
        BookAPI.shared.fetchBooks(query: "inauthor:\(authorName)") { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedBooks):
                    self.books = fetchedBooks
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch books for author \(authorName): \(error.localizedDescription)")
                    // Optionally show an alert to the user
                }
            }
        }
    }

    // MARK: - TableView DataSource and Delegate Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "authorBookCell", for: indexPath) as? AuthorBookTableViewCell else {
            return UITableViewCell()
        }

        let book = books[indexPath.row]
        cell.title.text = book.title
        if let averageRating = book.averageRating {
            cell.rating.text = "Rating: \(averageRating)"
        } else {
            cell.rating.text = "Rating: N/A"
        }
        cell.seriesInfo.text = book.subtitle ?? "Standalone Book"

        // Load the book cover image (from URL or placeholder)
        if let thumbnailUrlString = book.imageLinks?.thumbnail,
           let thumbnailUrl = URL(string: thumbnailUrlString) {
            loadImage(from: thumbnailUrl) { image in
                DispatchQueue.main.async {
                    cell.bookImage.image = image
                }
            }
        } else {
            cell.bookImage.image = UIImage(named: "placeholder_image")
        }

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
        let selectedBookIndex = sender.tag
        let selectedBook = books[selectedBookIndex]
        // Perform any actions for bookmarking the book here
        print("Bookmark button tapped for book: \(selectedBook.title)")
    }

    /// Helper method to load an image from a URL
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to load image from \(url): \(String(describing: error))")
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
        task.resume()
    }
}

