//
//  GuidedListViewController.swift
//  Eclipse
//
//  Created by user@87 on 18/11/24.
//

import UIKit

class GuidedListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var guidedLists = guidedListsData
    var author: Author!
    var selectedGuidedLists: GuidedLists?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionView.layer.cornerRadius = 10

        selectedGuidedLists = guidedLists.first { $0.authorID == author.authorID }

        if let selectedGuidedLists = selectedGuidedLists {
            descriptionLabel.text = selectedGuidedLists.description
        }
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedGuidedLists?.list.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guidedListTableCell", for: indexPath) as! GuidedListTableViewCell

        if let selectedGuidedLists = selectedGuidedLists {
            let guidedList = selectedGuidedLists.list[indexPath.row]
            cell.configure(with: guidedList)
        }
        
        return cell
    }
}
