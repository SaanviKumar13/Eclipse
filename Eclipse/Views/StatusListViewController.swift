import UIKit
import FirebaseFirestore
import FirebaseAuth

class StatusListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allBooks: [BookF] = []
    var filteredBooks: [BookF] = []
    var statusList: StatusList?
    private let db = Firestore.firestore()

    private var imageCache: [String: UIImage] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
        fetchBooksForStatus(statusList?.bookIDs ?? [])
    }

    private func setupNavigationBar() {
        title = statusList?.category
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
    }

    private func fetchBooksForStatus(_ bookIDs: [String]) {
        allBooks.removeAll()
        filteredBooks.removeAll()
        tableView.reloadData()
        
        fetchBooksByIDs(bookIDs)
    }

    private func fetchBooksByIDs(_ bookIDs: [String]) {
        let group = DispatchGroup()
        var fetchedBooks: [BookF] = []

        for bookID in bookIDs {
            group.enter()
            fetchGoogleBook(volumeId: bookID) { [weak self] result in
                switch result {
                case .success(let book):
                    if let book = book {
                        fetchedBooks.append(book)
                    }
                case .failure(let error):
                    print("Error fetching book \(bookID): \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.allBooks = fetchedBooks
            self.filteredBooks = fetchedBooks
            self.tableView.reloadData()
        }
    }

    private func fetchGoogleBook(volumeId: String, completion: @escaping (Result<BookF?, Error>) -> Void) {
        let baseUrlString = "https://www.googleapis.com/books/v1/volumes/\(volumeId)"
        guard let url = URL(string: baseUrlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.zeroByteResource)))
                return
            }

            do {
                let item = try JSONDecoder().decode(VolumeItem.self, from: data)
                if let volumeInfo = item.volumeInfo {
                    let book = BookF(
                        id: item.id,
                        title: volumeInfo.title,
                        subtitle: volumeInfo.subtitle ?? "",
                        authors: volumeInfo.authors ?? [],
                        description: volumeInfo.description ?? "",
                        averageRating: volumeInfo.averageRating ?? 0.0,
                        ratingsCount: volumeInfo.ratingsCount ?? 0,
                        imageLinks: volumeInfo.imageLinks,
                        previewLink: volumeInfo.previewLink ?? "",
                        pageCount: volumeInfo.pageCount ?? 0
                    )
                    completion(.success(book))
                } else {
                    completion(.success(nil))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatusBookCell", for: indexPath) as? StatusBookTableViewCell else {
            return UITableViewCell()
        }

        let book = filteredBooks[indexPath.row]
        configureCell(cell, with: book)
        cell.delegate = self // Set the delegate to self
        cell.book = book // Pass the book reference to the cell

        return cell
    }

    private func configureCell(_ cell: StatusBookTableViewCell, with book: BookF) {
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.authors?.joined(separator: ", ") ?? "Unknown Author"
        cell.descriptionLabel.text = book.description?.prefix(100).description ?? "No description available"
        
        if let thumbnailURL = book.imageLinks?.thumbnail {
            if let cachedImage = imageCache[thumbnailURL] {
                cell.bookImage.image = cachedImage
            } else {
                loadImage(from: thumbnailURL) { [weak self] image in
                    DispatchQueue.main.async {
                        cell.bookImage.image = image
                        self?.imageCache[thumbnailURL] = image
                    }
                }
            }
        } else {
            cell.bookImage.image = UIImage(systemName: "book")
        }
    }

    private func loadImage(from urlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(UIImage(systemName: "book") ?? UIImage())
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(UIImage(systemName: "book") ?? UIImage())
            }
        }.resume()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = filteredBooks[indexPath.row]
        let bookVC = BookViewController(book: selectedBook)
        navigationController?.pushViewController(bookVC, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredBooks = searchText.isEmpty ? allBooks : filterBooks(for: searchText)
        tableView.reloadData()
    }

    private func filterBooks(for searchText: String) -> [BookF] {
        return allBooks.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.authors?.joined(separator: ", ").localizedCaseInsensitiveContains(searchText) ?? false
        }
    }

    private func moveBook(_ book: BookF, to status: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userListsRef = db.collection("users").document(userID).collection("lists")
        
        getCurrentStatus(for: book.id) { [weak self] currentStatus in
            guard let self = self else { return }
            if currentStatus != status {
                let batch = self.db.batch()
                
                let currentStatusRef = userListsRef.document(currentStatus)
                currentStatusRef.getDocument { document, _ in
                    if let document = document, document.exists, let data = document.data(), let bookIDs = data["bookIDs"] as? [String], bookIDs.contains(book.id) {
                        batch.updateData(["bookIDs": FieldValue.arrayRemove([book.id])], forDocument: currentStatusRef)
                    }
                    
                    let newStatusRef = userListsRef.document(status)
                    newStatusRef.getDocument { newDocument, _ in
                        if let newDocument = newDocument, newDocument.exists, var bookIDs = newDocument.data()?["bookIDs"] as? [String] {
                            bookIDs.append(book.id)
                            batch.updateData(["bookIDs": bookIDs], forDocument: newStatusRef)
                        } else {
                            batch.setData(["bookIDs": [book.id]], forDocument: newStatusRef)
                        }
                        
                        batch.commit { [weak self] error in
                            guard let strongSelf = self else { return }
                            if let error = error {
                                print("Error moving book: \(error.localizedDescription)")
                            } else {
                                print("Book moved to \(status) list.")
                                strongSelf.fetchBooksForStatus(strongSelf.statusList?.bookIDs ?? [])
                            }
                        }
                    }
                }
            }
        }
    }

    private func deleteBook(_ book: BookF) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userListsRef = db.collection("users").document(userID).collection("lists")
        
        userListsRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching lists: \(error.localizedDescription)")
                return
            }
            
            let batch = self.db.batch()
            for document in snapshot!.documents {
                let docRef = userListsRef.document(document.documentID)
                batch.updateData(["bookIDs": FieldValue.arrayRemove([book.id])], forDocument: docRef)
            }
            
            batch.commit { [weak self] error in
                guard let strongSelf = self else { return }
                if let error = error {
                    print("Error deleting book: \(error.localizedDescription)")
                } else {
                    print("Book deleted from all lists.")
                    strongSelf.fetchBooksForStatus(strongSelf.statusList?.bookIDs ?? [])
                }
            }
        }
    }
    
    private func getCurrentStatus(for bookID: String, completion: @escaping (String) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion("Currently Reading") // Default status if user is not logged in
            return
        }

        let userStatusListsRef = db.collection("users").document(userID).collection("lists")
        
        // Query all status lists to find the current status of the book
        userStatusListsRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching status lists: \(error.localizedDescription)")
                completion("Currently Reading") // Default status on error
                return
            }
            
            for document in snapshot!.documents {
                if let books = document["books"] as? [String], books.contains(bookID) {
                    completion(document.documentID) // Return the status list name
                    return
                }
            }

            completion("Currently Reading") // Default if book not found in any list
        }
    }
}

extension StatusListViewController: StatusBookTableViewCellDelegate {
    func didSelectKebabMenu(for book: BookF) {
        let actionSheet = UIAlertController(title: "Manage Book", message: "Choose an action for the book", preferredStyle: .actionSheet)
        
        let statusList = ["Currently Reading", "Want to Read", "Finished", "Did Not Finish"]
        for status in statusList {
            actionSheet.addAction(UIAlertAction(title: status, style: .default, handler: { [weak self] _ in
                self?.moveBook(book, to: status)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteBook(book)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
}
