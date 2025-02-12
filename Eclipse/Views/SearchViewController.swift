import UIKit

// MARK: - Extended BookF (for SearchViewController)
extension BookF {
    struct SearchBookF: Codable {
        let id: String
        let volumeInfo: VolumeInfo
        
        struct VolumeInfo: Codable {
            let title: String
            let subtitle: String?
            let authors: [String]?
            let description: String?
            let averageRating: Double?
            let ratingsCount: Int?
            let imageLinks: ImageLinks?
            let previewLink: String?
            let pageCount: Int?
        }
    }
}

// MARK: - SearchViewController
class SearchViewController: UIViewController {
    // MARK: - UI Components
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Books"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private let resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        return tableView
    }()
    
    private var searchResults: [BookF.SearchBookF] = []
    private var timer: Timer?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the large title for the navigation bar
        navigationItem.title = "Search Books"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupUI()
        setupDelegates()
    }

    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(resultsTableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            resultsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDelegates() {
        searchBar.delegate = self
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
    }
    
    private func fetchBooks(query: String) {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let self = self, let data = data, error == nil else {
                print("Error fetching books: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(BookResponse.self, from: data)
                DispatchQueue.main.async {
                    self.searchResults = response.items ?? []
                    self.resultsTableView.reloadData()
                }
            } catch {
                print("JSON Decoding Error: \(error)")
            }
        }.resume()
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        guard !searchText.isEmpty else {
            searchResults.removeAll()
            resultsTableView.reloadData()
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.fetchBooks(query: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchResults.removeAll()
        resultsTableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDelegate & DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let book = searchResults[indexPath.row]
        
        content.text = book.volumeInfo.title
        content.secondaryText = book.volumeInfo.authors?.joined(separator: ", ") ?? "Unknown Author"
        
        // Display the thumbnail image if available
        if let thumbnail = book.volumeInfo.imageLinks?.thumbnail,
           let url = URL(string: thumbnail),
           let data = try? Data(contentsOf: url) {
            content.image = UIImage(data: data)
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSearchBook: BookF.SearchBookF = searchResults[indexPath.row]
        
        // Convert SearchBookF to the original BookF type
        let selectedBook = BookF(
            id: selectedSearchBook.id,
            title: selectedSearchBook.volumeInfo.title,
            subtitle: selectedSearchBook.volumeInfo.subtitle,
            authors: selectedSearchBook.volumeInfo.authors,
            description: selectedSearchBook.volumeInfo.description,
            averageRating: selectedSearchBook.volumeInfo.averageRating,
            ratingsCount: selectedSearchBook.volumeInfo.ratingsCount,
            imageLinks: selectedSearchBook.volumeInfo.imageLinks,
            previewLink: selectedSearchBook.volumeInfo.previewLink,
            pageCount: selectedSearchBook.volumeInfo.pageCount
        )
        
        let bookVC = BookViewController(book: selectedBook)
        navigationController?.pushViewController(bookVC, animated: true)
    }
}

// MARK: - Response Models
struct BookResponse: Codable {
    let items: [BookF.SearchBookF]?
}
