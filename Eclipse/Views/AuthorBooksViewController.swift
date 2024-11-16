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

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "authorBookCell", for: indexPath) as? AuthorBookTableViewCell else {
            return UITableViewCell()
        }
        
        let book = books[indexPath.row]
        print(book)
        cell.title.text = book.title
        cell.rating.text = "Rating: \(book.rating)"
        
        if let seriesInfo = book.seriesInfo {
            cell.seriesInfo.text = "\(seriesInfo.seriesName) - Book \(seriesInfo.bookOrder)"
        } else {
            cell.seriesInfo.text = "Standalone Book"
        }
        
        cell.bookImage.image = book.coverImageURL ?? UIImage(named: "placeholder_image")
        
        return cell
    }

    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

