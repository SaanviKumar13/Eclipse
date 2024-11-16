//
//  AuthorReadingListViewController.swift
//  Eclipse
//
//  Created by user@87 on 16/11/24.
//

import UIKit

class AuthorReadingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return statusLists.filter { !$0.isPrivate }.count
        } else {
            return customLists.filter { !$0.value.isPrivate }.keys.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "authorReadingListCell", for: indexPath) as? ReadingListTableViewCell else {
            return UITableViewCell()
        }

        if indexPath.section == 0 {
            let publicStatusLists = statusLists.filter { !$0.isPrivate }
            let statusList = publicStatusLists[indexPath.row]
            configure(cell, with: statusList, using: mockBooks)
        } else {
            let publicCustomLists = customLists.filter { !$0.value.isPrivate }
            let customListName = Array(publicCustomLists.keys)[indexPath.row]
            let customList = publicCustomLists[customListName]!
            configure(cell, with: customList, using: mockBooks)
        }

        return cell
    }

    private func configure(_ cell: ReadingListTableViewCell, with list: List, using books: [Book]) {
        cell.titleLabel.text = list.title
        cell.subtitleLabel.text = list.bookIDs.isEmpty ? "No books available" : "\(list.bookIDs.count) books"
        cell.privacyIndicator.image = list.isPrivate ? UIImage(systemName: "lock.fill") : UIImage(systemName: "network")
        setBookImages(for: cell, with: list.bookIDs.prefix(3), from: books)
    }

    private func setBookImages(for cell: ReadingListTableViewCell, with bookIDs: ArraySlice<String>, from books: [Book]) {
        var bookImages: [UIImage] = []
        for bookID in bookIDs {
            if let book = books.first(where: { $0.id == bookID }), let image = book.coverImageURL {
                bookImages.append(image)
            }
        }

        cell.book1.image = UIImage(named: "grey_bg")
        cell.book2.image = UIImage(named: "grey_bg")
        cell.book3.image = UIImage(named: "grey_bg")

        if bookImages.indices.contains(0) { cell.book1.image = bookImages[0] }
        if bookImages.indices.contains(1) { cell.book2.image = bookImages[1] }
        if bookImages.indices.contains(2) { cell.book3.image = bookImages[2] }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemGroupedBackground

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.text = section == 0 ? "Status Lists" : "Custom Lists"

        headerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showList", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showList",
           let destinationVC = segue.destination as? CustomListViewController,
           let indexPath = sender as? IndexPath {
            if indexPath.section == 0 {
                // Status Lists
                let publicStatusLists = statusLists.filter { !$0.isPrivate }
                let selectedStatus = publicStatusLists[indexPath.row]
                destinationVC.selectedListTitle = selectedStatus.title
                destinationVC.allBooks = mockBooks.filter { selectedStatus.bookIDs.contains($0.id) }
            } else if indexPath.section == 1 {
                // Custom Lists
                let publicCustomLists = customLists.filter { !$0.value.isPrivate }
                let customListName = Array(publicCustomLists.keys)[indexPath.row]
                let selectedCustomList = publicCustomLists[customListName]!
                destinationVC.selectedListTitle = selectedCustomList.title
                destinationVC.allBooks = mockBooks.filter { selectedCustomList.bookIDs.contains($0.id) }
            }
        }
    }

}

