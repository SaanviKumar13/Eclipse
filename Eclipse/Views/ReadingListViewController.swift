//
//  ReadingListViewController.swift
//  Eclipse
//
//  Created by user@87 on 30/10/24.
//
import UIKit

class ReadingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableView: UITableView!
    
    var customLists: [String: [String]] = [
        "Whodunit?": ["1", "6"],
        "Sci-Fi Adventures": ["2", "3"],
        "Historical Drama": ["5", "4"]
    ]

    var statusLists: [(title: String, bookIDs: [String])] = [
        ("Want To Read", ["1", "4", "6"]),
        ("Currently Reading", ["3"]),
        ("Finished", ["2", "5", "7"]),
        ("Did Not Finish", ["8"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(ReadingListTableViewCell.self, forCellReuseIdentifier: "ReadingListCell")
        
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
            cell.subtitleLabel.text = "\(statusList.bookIDs.count) books"
        } else {
            let customListName = Array(customLists.keys)[indexPath.row]
            let bookIDs = customLists[customListName] ?? []
            cell.titleLabel.text = customListName
            cell.subtitleLabel.text = "\(bookIDs.count) books"
        }

        cell.coverImageView.image = UIImage(named: "reading_list")

        return cell
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
