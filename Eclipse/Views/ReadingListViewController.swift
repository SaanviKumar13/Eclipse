//
//  ReadingListViewController.swift
//  Eclipse
//
//  Created by user@87 on 11/11/24.
//
import UIKit

class ReadingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        view.backgroundColor = .systemBackground
        setupTableView()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReadingListTableViewCell.self, forCellReuseIdentifier: "ReadingListCell")
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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

        let list: List
        if indexPath.section == 0 {
            list = statusLists[indexPath.row]
        } else {
            let customListName = Array(customLists.keys)[indexPath.row]
            list = customLists[customListName]!
        }
        
        configure(cell, with: list, using: mockBooks)
        
        return cell
    }

    private func configure(_ cell: ReadingListTableViewCell, with list: List, using books: [Book]) {
        cell.titleLabel.text = list.title
        cell.subtitleLabel.text = list.bookIDs.isEmpty ? "No books available" : "\(list.bookIDs.count) books"
        cell.privacyIndicator.image = list.isPrivate ? UIImage(systemName: "lock.fill") : UIImage(systemName: "network")

        let bookImages: [UIImage] = list.bookIDs.prefix(3).compactMap { bookID in
            books.first(where: { $0.id == bookID })?.coverImageURL
        }
        cell.setThumbnails(images: bookImages)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemGroupedBackground

        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
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
            createButton.backgroundColor = .clear
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
            // Instantiate StatusListViewController and pass data
            let statusListVC = StatusListViewController()
            let selectedStatus = statusLists[indexPath.row]
            statusListVC.selectedStatusTitle = selectedStatus.title
            statusListVC.allBooks = mockBooks.filter { selectedStatus.bookIDs.contains($0.id) }

            // Push the StatusListViewController onto the navigation stack
            navigationController?.pushViewController(statusListVC, animated: true)
        } else {
            // Instantiate CustomListViewController and pass data
            let customListVC = CustomListViewController()
            let customListName = Array(customLists.keys)[indexPath.row]
            let selectedCustomList = customLists[customListName]!
            customListVC.selectedListTitle = selectedCustomList.title
            customListVC.allBooks = mockBooks.filter { selectedCustomList.bookIDs.contains($0.id) }

            // Push the CustomListViewController onto the navigation stack
            navigationController?.pushViewController(customListVC, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc private func createNewCollectionTapped(_ sender: UIButton) {
        let createVC = CreateCollectionViewController()
        let navController = UINavigationController(rootViewController: createVC)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: true, completion: nil)
    }
}

