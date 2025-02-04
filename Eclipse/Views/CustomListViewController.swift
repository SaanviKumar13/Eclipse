import UIKit
import FirebaseFirestore
import FirebaseAuth

class CustomListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var allBooks: [BookF] = []
    var customList: List?
    private let db = Firestore.firestore()
    
    private var imageCache: [String: UIImage] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        print(customList)
        
        if let list = customList, !list.bookIDs.isEmpty {
            fetchBooksForList(list)
        }
    }

    private func setupNavigationBar() {
        navigationItem.title = customList?.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func fetchBooksForList(_ list: List) {
        let bookIDs = list.bookIDs
        
        allBooks.removeAll()
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
            print("Books fetched: \(fetchedBooks.count)")
            self.allBooks = fetchedBooks
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
        return allBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomListBookCell", for: indexPath) as? CustomBookTableViewCell else {
            return UITableViewCell()
        }

        let book = allBooks[indexPath.row]
        configureCell(cell, with: book)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = allBooks[indexPath.row]
        let bookVC = BookViewController(book: selectedBook)
        navigationController?.pushViewController(bookVC, animated: true)
    }

    private func configureCell(_ cell: CustomBookTableViewCell, with book: BookF) {
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
}

