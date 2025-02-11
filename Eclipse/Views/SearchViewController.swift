//
//  SearchViewController.swift
//  Eclipse
//
//  Created by admin48 on 10/02/25.
//



import UIKit

class SearchViewController: UIViewController {
    // MARK: - UI Components
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .systemBackground
        return searchBar
    }()
    
    private let recentSearchesLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Searches"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let recentSearchesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray5
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()
    
    private var recentSearches: [Book] = Array(mockBooks.prefix(3)) // Displaying only 3 recent books

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setupDelegates()
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    private func setupDelegates() {
        searchBar.delegate = self
        recentSearchesTableView.delegate = self
        recentSearchesTableView.dataSource = self
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(recentSearchesLabel)
        view.addSubview(recentSearchesTableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        recentSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
        recentSearchesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            recentSearchesLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            recentSearchesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            recentSearchesTableView.topAnchor.constraint(equalTo: recentSearchesLabel.bottomAnchor, constant: 10),
            recentSearchesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recentSearchesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentSearchesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        let filteredBooks = mockBooks.filter { $0.title.lowercased().contains(query.lowercased()) }
        
        if let firstBook = filteredBooks.first {
            let bookVC = BookViewController(book: firstBook)
            navigationController?.pushViewController(bookVC, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate & DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = recentSearches[indexPath.row].title
        content.textProperties.font = .systemFont(ofSize: 16)
        cell.contentConfiguration = content
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = recentSearches[indexPath.row]
        let bookVC = BookViewController(book: selectedBook)
        navigationController?.pushViewController(bookVC, animated: true)
    }
}


//import FirebaseFirestore
//
//private let db = Firestore.firestore()
//private let userId = "user_123" // Replace with the actual logged-in user's ID
//
//import UIKit
//
//class SearchViewController: UIViewController {
//    // MARK: - UI Components
//    private let searchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.placeholder = "Search"
//        searchBar.searchBarStyle = .minimal
//        searchBar.backgroundColor = .systemBackground
//        return searchBar
//    }()
//    
//    private let recentSearchesLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Recent Searches"
//        label.font = .systemFont(ofSize: 18, weight: .semibold)
//        return label
//    }()
//    
//    private let recentSearchesTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
//        tableView.backgroundColor = .systemBackground
//        tableView.separatorStyle = .singleLine
//        tableView.separatorColor = .systemGray5
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//        return tableView
//    }()
//    
//    private var recentSearches: [Book] = Array(mockBooks.prefix(3)) // Displaying only 3 recent books
//
//    // MARK: - Lifecycle Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar()
//        setupUI()
//        setupDelegates()
//        
//        loadRecentSearches()
//    }
//    
//    // MARK: - Setup Methods
//    private func setupNavigationBar() {
//        navigationItem.title = "Search"
//        navigationController?.navigationBar.tintColor = .systemBlue
//    }
//    
//    private func setupDelegates() {
//        searchBar.delegate = self
//        recentSearchesTableView.delegate = self
//        recentSearchesTableView.dataSource = self
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .systemBackground
//        
//        view.addSubview(searchBar)
//        view.addSubview(recentSearchesLabel)
//        view.addSubview(recentSearchesTableView)
//        
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        recentSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
//        recentSearchesTableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            recentSearchesLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
//            recentSearchesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            
//            recentSearchesTableView.topAnchor.constraint(equalTo: recentSearchesLabel.bottomAnchor, constant: 10),
//            recentSearchesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            recentSearchesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            recentSearchesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    private func loadRecentSearches() {
//        db.collection("recentSearches")
//            .whereField("userId", isEqualTo: userId)
//            .order(by: "timestamp", descending: true)
//            .limit(to: 3)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("❌ Error fetching recent searches: \(error)")
//                    return
//                }
//
//                let searchedBookIds = snapshot?.documents.compactMap { $0.data()["searchedBookId"] as? String } ?? []
//
//                self.fetchBooks(for: searchedBookIds) // Fetch book details
//            }
//    }
//    private func fetchBooks(for bookIds: [String]) {
//        if bookIds.isEmpty {
//            self.recentSearches = []
//            DispatchQueue.main.async { self.recentSearchesTableView.reloadData() }
//            return
//        }
//
//        db.collection("books").whereField(FieldPath.documentID(), in: bookIds)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("❌ Error fetching books: \(error)")
//                    return
//                }
//
//                self.recentSearches = snapshot?.documents.compactMap { doc -> Book? in
//                    let data = doc.data()
//                    return Book(
//                        id: doc.documentID,
//                        title: data["title"] as? String ?? "Unknown",
//                        author: data["author"] as? String ?? "Unknown",
//                        coverImageURL: data["coverImageURL"] as? String ?? ""
//                    )
//                } ?? []
//
//                DispatchQueue.main.async {
//                    self.recentSearchesTableView.reloadData()
//                }
//            }
//    }
//
//
//}
//
//// MARK: - UISearchBarDelegate
//extension SearchViewController: UISearchBarDelegate {
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = true
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = false
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let query = searchBar.text, !query.isEmpty else { return }
//
//        db.collection("books").whereField("title", isGreaterThanOrEqualTo: query)
//            .whereField("title", isLessThanOrEqualTo: query + "\u{f8ff}") // Firestore range query
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("❌ Error fetching books: \(error)")
//                    return
//                }
//
//                let filteredBooks = snapshot?.documents.compactMap { doc -> Book? in
//                    let data = doc.data()
//
//                    guard let authorData = data["author"] as? [String: Any],
//                          let authorName = authorData["name"] as? String else { return nil }
//
//                    let author = Author(name: authorName) // Adjust if more fields exist
//
//                    let tagsArray = data["tags"] as? [String] ?? []
//                    let tags = tagsArray.map { Tag(name: $0) }
//
//                    let seriesInfoData = data["seriesInfo"] as? [String: Any]
//                    let seriesInfo = seriesInfoData != nil ? SeriesInfo(
//                        seriesName: seriesInfoData?["seriesName"] as? String ?? "",
//                        bookNumber: seriesInfoData?["bookNumber"] as? Int ?? 1
//                    ) : nil
//
//                    let statusData = data["status"] as? String
//                    let status = statusData != nil ? Status(rawValue: statusData!) : nil
//
//                    return Book(
//                        id: doc.documentID,
//                        title: data["title"] as? String ?? "Unknown",
//                        author: author,
//                        genre: data["genre"] as? String ?? "Unknown",
//                        description: data["description"] as? String ?? "",
//                        coverImageURL: nil, // Load separately
//                        tags: tags,
//                        rating: data["rating"] as? Double ?? 0.0,
//                        price: data["price"] as? Double,
//                        rentersNearby: data["rentersNearby"] as? Int ?? 0,
//                        seriesInfo: seriesInfo,
//                        status: status,
//                        isCollectorsEdition: data["isCollectorsEdition"] as? Bool ?? false
//                    )
//                } ?? []
//
//                DispatchQueue.main.async {
//                    if let firstBook = filteredBooks.first {
//                        self.saveRecentSearch(bookId: firstBook.id) // 🔥 Save recent search
//                        let bookVC = BookViewController(book: firstBook)
//                        self.navigationController?.pushViewController(bookVC, animated: true)
//                    }
//                }
//            }
//    }
//
//    
//    private func saveRecentSearch(bookId: String) {
//        let recentSearchRef = db.collection("recentSearches").document()
//
//        recentSearchRef.setData([
//            "userId": userId,
//            "searchedBookId": bookId,
//            "timestamp": Timestamp()
//        ]) { error in
//            if let error = error {
//                print("❌ Error saving recent search: \(error)")
//            } else {
//                print("✅ Recent search saved!")
//                self.loadRecentSearches() // Refresh UI
//            }
//        }
//    }
//
//
//}
//
//// MARK: - UITableViewDelegate & DataSource
//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return recentSearches.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
//        
//        var content = cell.defaultContentConfiguration()
//        content.text = recentSearches[indexPath.row].title
//        content.textProperties.font = .systemFont(ofSize: 16)
//        cell.contentConfiguration = content
//        
//        cell.selectionStyle = .none
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedBook = recentSearches[indexPath.row]
//        let bookVC = BookViewController(book: selectedBook)
//        navigationController?.pushViewController(bookVC, animated: true)
//    }
//}
