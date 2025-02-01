import Firebase
import FirebaseFirestore
import FirebaseAuth
import UIKit

struct VolumeItem: Codable {
    let id: String
    let volumeInfo: VolumeInfo?
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let description: String?
    let pageCount: Int?
    let averageRating: Double?
    let ratingsCount: Int?
    let imageLinks: ImageLinks?
    let previewLink: String?
}

class BookCollectionViewCell: UICollectionViewCell {
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private var imageLoadTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupStyling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(coverImageView)
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupStyling() {
        backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        layer.cornerRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    func configure(with book: BookF) {
        imageLoadTask?.cancel()
        imageLoadTask = nil
        coverImageView.image = nil
        
        if let imageUrlString = book.imageLinks?.thumbnail?.replacingOccurrences(of: "http://", with: "https://"),
           let imageUrl = URL(string: imageUrlString) {
            loadImage(from: imageUrl.absoluteString)
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        imageLoadTask?.cancel()

        imageLoadTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                print("Image load error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid HTTP response")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to create image from data")
                return
            }

            DispatchQueue.main.async {
                UIView.transition(with: self.coverImageView,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.coverImageView.image = image
                })
            }
        }

        imageLoadTask?.resume()
    }


    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadTask?.cancel()
        imageLoadTask = nil
        coverImageView.image = nil
    }
}

class AllBooksViewController: UIViewController {
    
    private let gridCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private var displayedBooks: [BookF] = [] {
        didSet {
            DispatchQueue.main.async {
                self.gridCollectionView.reloadData()
            }
        }
    }
    
    private let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionViews()
        fetchBooks()
    }

    private func setupCollectionViews() {
        view.addSubview(gridCollectionView)
        
        gridCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gridCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            gridCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gridCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gridCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        gridCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCell")
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
    }

    private func fetchBooks() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        
        let group = DispatchGroup()
        var allBookIds = Set<String>()

        group.enter()
        fetchBookIds(from: "lists", userID: userID) { result in
            defer { group.leave() }
            if case .success(let ids) = result {
                allBookIds.formUnion(ids)
            }
        }

        group.enter()
        fetchBookIds(from: "customLists", userID: userID) { result in
            defer { group.leave() }
            if case .success(let ids) = result {
                allBookIds.formUnion(ids)
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            if !allBookIds.isEmpty {
                self?.fetchGoogleBooks(bookIds: Array(allBookIds))
            } else {
                print("No book IDs found in lists")
            }
        }
    }
    
    private func fetchBookIds(from collection: String, userID: String, completion: @escaping (Result<Set<String>, Error>) -> Void) {
        db.collection("users").document(userID).collection(collection).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching \(collection): \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            let bookIds = snapshot?.documents.compactMap { document -> [String]? in
                document.data()["bookIDs"] as? [String]
            }.flatMap { $0 } ?? []
            
            completion(.success(Set(bookIds)))
        }
    }
    
    private func fetchGoogleBooks(bookIds: [String]) {
        let group = DispatchGroup()
        var allBooks: [BookF] = []
        var errors: [Error] = []
        
        for bookId in bookIds {
            group.enter()
            fetchGoogleBook(volumeId: bookId) { result in
                defer { group.leave() }
                switch result {
                case .success(let book):
                    if let book = book {
                        allBooks.append(book)
                    }
                case .failure(let error):
                    errors.append(error)
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            if !errors.isEmpty {
                print("Encountered \(errors.count) errors while fetching books")
            }
            self?.displayedBooks = allBooks
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
                        subtitle: volumeInfo.subtitle,
                        authors: volumeInfo.authors,
                        description: volumeInfo.description,
                        averageRating: volumeInfo.averageRating,
                        ratingsCount: volumeInfo.ratingsCount,
                        imageLinks: volumeInfo.imageLinks,
                        previewLink: volumeInfo.previewLink,
                        pageCount: volumeInfo.pageCount
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
}

extension AllBooksViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let book = displayedBooks[indexPath.item]
        cell.configure(with: book)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 30) / 2
            return CGSize(width: width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = displayedBooks[indexPath.item]
        let bookDetailVC = BookViewController(book: selectedBook)
        navigationController?.pushViewController(bookDetailVC, animated: true)
    }
}
