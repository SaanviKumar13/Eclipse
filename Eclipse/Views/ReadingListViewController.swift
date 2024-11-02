//
//  ReadingListViewController.swift
//  Eclipse
//
//  Created by user@87 on 30/10/24.
//

import UIKit

class ReadingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct List {
        let title: String
        let bookIDs: [String]
        let isPrivate: Bool
    }
    
    var statusLists: [List] = [
        List(title: "Want To Read", bookIDs: wantToReadList, isPrivate: false),
        List(title: "Currently Reading", bookIDs: currentlyReadingList, isPrivate: true),
        List(title: "Finished", bookIDs: finishedList, isPrivate: false),
        List(title: "Did Not Finish", bookIDs: didNotFinishList, isPrivate: true)
    ]

    var customLists: [String: List] = [
        "Whodunit?": List(title: "Whodunit?", bookIDs: whodunitList, isPrivate: false),
        "Sci-Fi Adventures": List(title: "Sci-Fi Adventures", bookIDs: sciFiAdventuresList, isPrivate: true),
        "Historical Drama": List(title: "Historical Drama", bookIDs: historicalDramaList, isPrivate: false)
    ]

    @IBOutlet weak var TableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? statusLists.count : customLists.keys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingListCell", for: indexPath) as? ReadingListTableViewCell else {
            return UITableViewCell()
        }

        if indexPath.section == 0 {
            let statusList = statusLists[indexPath.row]
            cell.titleLabel.text = statusList.title
            cell.subtitleLabel.text = statusList.bookIDs.isEmpty ? "No books available" : "\(statusList.bookIDs.count) books"
            cell.privacyIndicator.image = statusList.isPrivate ? UIImage(systemName: "lock.fill") : UIImage(systemName: "network")
            let bookIDs = statusList.bookIDs.prefix(3)
            setBookImages(for: cell, with: bookIDs, from: mockBooks)

        } else {
            let customListName = Array(customLists.keys)[indexPath.row]
            let customList = customLists[customListName]!
            cell.titleLabel.text = customList.title
            let bookIDs = customList.bookIDs
            cell.subtitleLabel.text = "\(bookIDs.count) books"
            cell.privacyIndicator.image = customList.isPrivate ? UIImage(systemName: "lock.fill") : UIImage(systemName: "network")
            let bookIDsToDisplay = bookIDs.prefix(3)
            setBookImages(for: cell, with: bookIDsToDisplay, from: mockBooks)
        }
        
        return cell
    }

    private func setBookImages(for cell: ReadingListTableViewCell, with bookIDs: ArraySlice<String>, from books: [Book]) {
        var bookImages: [UIImage] = []
        for bookID in bookIDs {
            if let book = books.first(where: { $0.id == bookID }) {
                if let image = book.coverImageURL {
                    bookImages.append(image)
                }
            }
        }
        cell.book1.image = nil
        cell.book2.image = nil
        cell.book3.image = nil
        if bookImages.indices.contains(0) {
            cell.book1.image = bookImages[0]
        }
        if bookImages.indices.contains(1) {
            cell.book2.image = bookImages[1]
        }
        if bookImages.indices.contains(2) {
            cell.book3.image = bookImages[2]
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemGroupedBackground

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

        if section == 0 {
            titleLabel.text = "Status Lists"
        } else {
            titleLabel.text = "Custom Lists"

            let createButton = UIButton(type: .system)
            createButton.translatesAutoresizingMaskIntoConstraints = false
            createButton.setTitle("Create New Collection", for: .normal)

            headerView.addSubview(createButton)

            NSLayoutConstraint.activate([
                createButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                createButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
        }

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
}

