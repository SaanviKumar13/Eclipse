import UIKit

protocol StatusBookTableViewCellDelegate: AnyObject {
    func didSelectKebabMenu(for book: Book)
}

class StatusListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var allBooks: [Book] = []
    var filteredBooks: [Book] = []
    var selectedStatusTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
        filteredBooks = allBooks
    }
    
    private func setupNavigationBar() {
        title = selectedStatusTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatusBookCell", for: indexPath) as? StatusBookTableViewCell else {
            return UITableViewCell()
        }

        let book = filteredBooks[indexPath.row]
        cell.delegate = self
        configureCell(cell, with: book)

        return cell
    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedBook = filteredBooks[indexPath.item]
//        let bookVC = BookViewController(book: selectedBook)
//        navigationController?.pushViewController(bookVC, animated: true)
//    }

    private func configureCell(_ cell: StatusBookTableViewCell, with book: Book) {
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.author.name
        cell.descriptionLabel.text = book.description
        cell.bookImage.image = book.coverImageURL ?? UIImage(systemName: "book")
        cell.book = book
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredBooks = searchText.isEmpty ? allBooks : filterBooks(for: searchText)
        tableView.reloadData()
    }
    
    private func filterBooks(for searchText: String) -> [Book] {
        return allBooks.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.author.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}

extension StatusListViewController: StatusBookTableViewCellDelegate {
    func didSelectKebabMenu(for book: Book) {
        let currentStatus = getCurrentStatus(for: book.id) ?? "Unknown Status"
        let alertTitle = "\(book.title) is currently in \(currentStatus.lowercased().replacingOccurrences(of: "_", with: " "))"
        
        let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .actionSheet)

        let nextActions = getNextActions(for: book)
        for actionTitle in nextActions {
            let action = UIAlertAction(title: actionTitle, style: .default) { _ in
                self.moveBookToStatus(book, status: actionTitle)
            }
            alertController.addAction(action)
        }

        let removeFromLibraryAction = UIAlertAction(title: "Remove from Library", style: .destructive) { _ in
            self.removeBookFromLibrary(book)
        }
        alertController.addAction(removeFromLibraryAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    private func getNextActions(for book: Book) -> [String] {
        var actions: [String] = []
        
        if let currentStatus = getCurrentStatus(for: book.id) {
            switch currentStatus {
            case "want to read":
                actions.append("Move to Currently Reading")
            case "currently reading":
                actions.append("Move to Finished")
                actions.append("Move to Did Not Finish")
            case "finished":
                actions.append("Move to Did Not Finish")
            default:
                break
            }
        }
        
        return actions
    }

    private func moveBookToStatus(_ book: Book, status: String) {
        if let index = allBooks.firstIndex(where: { $0.id == book.id }) {
            allBooks.remove(at: index)
            filteredBooks.removeAll(where: { $0.id == book.id })

            switch status {
            case "Move to Currently Reading":
                currentlyReadingList.append(book.id)
            case "Move to Finished":
                finishedList.append(book.id)
            case "Move to Did Not Finish":
                didNotFinishList.append(book.id)
            default:
                break
            }
            tableView.reloadData()
        }
    }

    private func getCurrentStatus(for bookID: String) -> String? {
        if wantToReadList.contains(bookID) {
            return "want to read"
        } else if currentlyReadingList.contains(bookID) {
            return "currently reading"
        } else if finishedList.contains(bookID) {
            return "finished"
        } else if didNotFinishList.contains(bookID) {
            return "did not finish"
        } else {
            return nil
        }
    }

    private func removeBookFromLibrary(_ book: Book) {
        if let index = allBooks.firstIndex(where: { $0.id == book.id }) {
            allBooks.remove(at: index)
            filteredBooks.removeAll(where: { $0.id == book.id })
            tableView.reloadData()
        }
    }
}

