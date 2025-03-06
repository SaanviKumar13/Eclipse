import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class StatusListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private let db = Firestore.firestore()
    private var allBooks: [BookF] = []
    private var filteredBooks: [BookF] = []
    private var statusList: StatusList?

    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    func setStatusList(_ list: StatusList) {
        self.statusList = list
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchBooks()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        searchBar.delegate = self
        searchBar.placeholder = "Search books..."
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "BookCell")

        let stackView = UIStackView(arrangedSubviews: [searchBar, tableView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Fetch Books from Firestore
    private func fetchBooks() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let userListsRef = db.collection("users").document(userID).collection("lists").document(statusList?.category ?? "")
        userListsRef.getDocument { [weak self] document, error in
            guard let self = self, let data = document?.data(), error == nil else {
                print("Error fetching books: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let bookIDs = data["bookIDs"] as? [String] {
                self.fetchBookDetails(for: bookIDs)
            }
        }
    }

    private func fetchBookDetails(for bookIDs: [String]) {
        guard !bookIDs.isEmpty else {
            self.allBooks = []
            self.filteredBooks = []
            self.tableView.reloadData()
            return
        }
        
        let booksCollection = db.collection("books")
        let group = DispatchGroup()
        var books: [BookF] = []

        for bookID in bookIDs {
            group.enter()
            booksCollection.document(bookID).getDocument { document, error in
                if let document = document, document.exists, let book = try? document.data(as: BookF.self) {
                    books.append(book)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.allBooks = books
            self.filteredBooks = books
            self.tableView.reloadData()
        }
    }

    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        let book = filteredBooks[indexPath.row]
        cell.configure(with: book)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = filteredBooks[indexPath.row]
        let bookVC = BookViewController(book: selectedBook)
        navigationController?.pushViewController(bookVC, animated: true)
    }

    // MARK: - SearchBar Methods
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

    // MARK: - Move Book to Another Status List
    private func moveBook(_ book: BookF, to status: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userListsRef = db.collection("users").document(userID).collection("lists")

        getCurrentStatus(for: book.id) { [weak self] currentStatus in
            guard let self = self, currentStatus != status else { return }

            let batch = self.db.batch()
            let currentStatusRef = userListsRef.document(currentStatus)

            currentStatusRef.getDocument { document, _ in
                if let document = document, document.exists,
                   let bookIDs = document.data()?["bookIDs"] as? [String], bookIDs.contains(book.id) {
                    batch.updateData(["bookIDs": FieldValue.arrayRemove([book.id])], forDocument: currentStatusRef)
                }

                let newStatusRef = userListsRef.document(status)
                newStatusRef.getDocument { newDocument, _ in
                    if let newDocument = newDocument, newDocument.exists {
                        batch.updateData(["bookIDs": FieldValue.arrayUnion([book.id])], forDocument: newStatusRef)
                    } else {
                        batch.setData(["bookIDs": [book.id]], forDocument: newStatusRef)
                    }

                    batch.commit { [weak self] error in
                        guard let strongSelf = self else { return }
                        if let error = error {
                            print("Error moving book: \(error.localizedDescription)")
                        } else {
                            print("Book moved to \(status) list.")
                            strongSelf.fetchBooks()
                        }
                    }
                }
            }
        }
    }

    // MARK: - Delete Book from All Lists
    private func deleteBook(_ book: BookF) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userListsRef = db.collection("users").document(userID).collection("lists")

        userListsRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching lists: \(error.localizedDescription)")
                return
            }

            let batch = self.db.batch()
            snapshot?.documents.forEach { document in
                let docRef = userListsRef.document(document.documentID)
                batch.updateData(["bookIDs": FieldValue.arrayRemove([book.id])], forDocument: docRef)
            }

            batch.commit { [weak self] error in
                guard let strongSelf = self else { return }
                if let error = error {
                    print("Error deleting book: \(error.localizedDescription)")
                } else {
                    print("Book deleted from all lists.")
                    strongSelf.fetchBooks()
                }
            }
        }
    }

    // MARK: - Get Current Status of a Book
    private func getCurrentStatus(for bookID: String, completion: @escaping (String) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion("Currently Reading")
            return
        }

        let userStatusListsRef = db.collection("users").document(userID).collection("lists")

        userStatusListsRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching status lists: \(error.localizedDescription)")
                completion("Currently Reading")
                return
            }

            for document in snapshot!.documents {
                if let books = document["bookIDs"] as? [String], books.contains(bookID) {
                    completion(document.documentID)
                    return
                }
            }

            completion("Currently Reading")
        }
    }
}

class BookTableViewCell: UITableViewCell {
    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var actionButtonHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(bookImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(actionButton)

        NSLayoutConstraint.activate([
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bookImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            bookImageView.widthAnchor.constraint(equalToConstant: 50),
            bookImageView.heightAnchor.constraint(equalToConstant: 70),
            
            titleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: bookImageView.topAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 12),
            authorLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -10),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 30),
            actionButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    @objc private func didTapActionButton() {
        actionButtonHandler?()
    }
    
    func configure(with book: BookF) {
        titleLabel.text = book.title
        authorLabel.text = book.authors?.joined(separator: ", ") ?? "Unknown Author"
        
        if let imageUrl = book.imageLinks?.thumbnail {
            bookImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(systemName: "book.fill"))
        } else {
            bookImageView.image = UIImage(systemName: "book.fill")
        }
    }
}


