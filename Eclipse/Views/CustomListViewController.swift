//
//  CustomListViewController.swift
//  Eclipse
//
//  Created by user@87 on 05/11/24.
//

import UIKit

class CustomListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var allBooks: [BookF] = []
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = allBooks[indexPath.item]
        let bookVC = BookViewController(book: selectedBook)
        navigationController?.pushViewController(bookVC, animated: true)
    }

    private func configureCell(_ cell: CustomBookTableViewCell, with book: BookF) {
        
        cell.titleLabel.text = book.title
        
        if let authors = book.authors, !authors.isEmpty {
            cell.authorLabel.text = authors.joined(separator: ", ")
        } else {
            cell.authorLabel.text = "Unknown Author"
        }
        
        cell.descriptionLabel.text = book.description ?? "No description available"
        
        if let thumbnailURL = book.imageLinks?.thumbnail, let url = URL(string: thumbnailURL) {
            let session = URLSession(configuration: .default)
            let downloadTask = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error loading thumbnail: \(error)")
                    DispatchQueue.main.async {
                        cell.bookImage.image = UIImage(systemName: "book")
                    }
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.bookImage.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        cell.bookImage.image = UIImage(systemName: "book")
                    }
                }
            }
            downloadTask.resume()
        } else {
            cell.bookImage.image = UIImage(systemName: "book") 
        }
    }


}
