//
//  ReadingListViewController.swift
//  Eclipse
//
//  Created by user@87 on 30/10/24.
//

import UIKit

class ReadingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        return section == 0 ? statusLists.count : customLists.keys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingListCell", for: indexPath) as? ReadingListTableViewCell else {
            return UITableViewCell()
        }

        if indexPath.section == 0 {
            let statusList = statusLists[indexPath.row]
            configure(cell, with: statusList, using: mockBooks)
        } else {
            let customListName = Array(customLists.keys)[indexPath.row]
            let customList = customLists[customListName]!
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

        if section == 1 {
            let createButton = UIButton(type: .system)
            createButton.translatesAutoresizingMaskIntoConstraints = false
            createButton.setTitle("Create New Collection", for: .normal)
            headerView.addSubview(createButton)
            
            NSLayoutConstraint.activate([
                createButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                createButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            createButton.addTarget(self, action: #selector(createNewCollectionTapped), for: .touchUpInside)
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showStatusList", sender: indexPath)
        } else {
            performSegue(withIdentifier: "showCustomList", sender: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func createNewCollectionTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let createVC = storyboard.instantiateViewController(withIdentifier: "CreateCollectionViewController") as? CreateCollectionViewController {
            let navController = UINavigationController(rootViewController: createVC)
            navController.modalPresentationStyle = .formSheet
            present(navController, animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath {
            if segue.identifier == "showStatusList",
               let destinationVC = segue.destination as? StatusListViewController {
                let selectedStatus = statusLists[indexPath.row]
                destinationVC.selectedStatusTitle = selectedStatus.title
                destinationVC.allBooks = mockBooks.filter { selectedStatus.bookIDs.contains($0.id) }
            } else if segue.identifier == "showCustomList",
                      let destinationVC = segue.destination as? CustomListViewController {
                let customListName = Array(customLists.keys)[indexPath.row]
                let selectedCustomList = customLists[customListName]!
                destinationVC.selectedListTitle = selectedCustomList.title
                destinationVC.allBooks = mockBooks.filter { selectedCustomList.bookIDs.contains($0.id) }
            }
        }
    }
}

