import UIKit

class AddToLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var statusTableView: UITableView!
    @IBOutlet weak var customListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        statusTableView.dataSource = self
        statusTableView.delegate = self
        customListTableView.dataSource = self
        customListTableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == statusTableView {
            return statusLists.count
        } else {
            return customLists.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == statusTableView {
            return "Set Reading Status"
        } else {
            return "Add to Custom Lists"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == statusTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "setStatusCell", for: indexPath) as? AddToLibraryTableViewCell else {
                return UITableViewCell()
            }
            let statusList = statusLists[indexPath.row]
            cell.statusLabel.text = statusList.title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "customListCell", for: indexPath) as? ReadingListTableViewCell else {
                return UITableViewCell()
            }
            let customListName = Array(customLists.keys)[indexPath.row]
            if let customList = customLists[customListName] {
                configure(cell, with: customList, using: mockBooks)
            }
            return cell
        }
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


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == statusTableView {
            let selectedStatus = statusLists[indexPath.row]
            print("Selected status: \(selectedStatus.title)")
        } else {
            let customListName = Array(customLists.keys)[indexPath.row]
            if let selectedCustomList = customLists[customListName] {
                print("Selected custom list: \(selectedCustomList.title)")
            }
        }
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        print("Save button tapped")
        dismiss(animated: true, completion: nil)
    }
}

