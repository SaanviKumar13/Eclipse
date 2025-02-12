//  Created by admin48 on 18/11/24.
//

//import UIKit
//
//class RentHomeViewController: UIViewController {
//
//    private let scrollView: UIScrollView = {
//        let scroll = UIScrollView()
//        scroll.translatesAutoresizingMaskIntoConstraints = false
//        scroll.showsVerticalScrollIndicator = false
//        return scroll
//    }()
//    
//    private let contentView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let searchContainer: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBackground
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private lazy var searchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.placeholder = "Rent your next read..."
//        searchBar.searchBarStyle = .minimal
//        searchBar.searchTextField.backgroundColor = .secondarySystemBackground
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        return searchBar
//    }()
//    
////    private let profileButton: UIButton = {
////        let button = UIButton()
////        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
////        let image = UIImage(named: "profile")
////        button.setImage(image, for: .normal)
////        button.tintColor = .systemBlue
////        button.translatesAutoresizingMaskIntoConstraints = false
////        return button
////    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Rent from your\nCommunity"
//        label.numberOfLines = 2
//        label.font = .systemFont(ofSize: 30, weight: .bold)
//        return label
//    }()
//    
//    private let currentlyRentedLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Currently Rented"
//        label.font = .systemFont(ofSize: 20, weight: .medium)
//        return label
//    }()
//    
//    private let seeMoreButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("See more >", for: .normal)
//        button.setTitleColor(.systemBlue, for: .normal)
//        return button
//    }()
//    
//    private let currentlyRentedCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 15
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.showsHorizontalScrollIndicator = false
//        cv.backgroundColor = .clear
//        return cv
//    }()
//    
//    private let rentersLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Top Renters in your Area"
//        label.font = .systemFont(ofSize: 25, weight: .medium)
//        return label
//    }()
//    
//    private let rentersCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 15
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.showsHorizontalScrollIndicator = false
//        cv.backgroundColor = .clear
//        return cv
//    }()
//    
//    private let suggestedBooksLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Books you might like to rent"
//        label.font = .systemFont(ofSize: 25, weight: .medium)
//        return label
//    }()
//    
//    private let suggestedBooksCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 15
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.showsHorizontalScrollIndicator = false
//        cv.backgroundColor = .clear
//        return cv
//    }()
//
//    private let currentlyRentedBooks = ["4", "9"]
//    private let renterProfiles = ["profile", "profile", "profile", "profile", "profile"]
//    private let renterNames = ["Sara\nMukhija", "Dhruv\nSharma", "Ananya\nSharma", "Raj\nVerma"]
//    private let suggestedBooks = ["13", "17", "12", "11", "19"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupCollectionViews()
//    }
//    
//    @objc private func seemoreButtonTapped() {
//        let chattVC = BookManagementViewController()
//
//        navigationController?.pushViewController(chattVC, animated: true)
//    }
//
//    private func setupUI() {
//        view.backgroundColor = .white
//        
//        view.addSubview(scrollView)
//        view.addSubview(seeMoreButton)
//        scrollView.addSubview(contentView)
//        
//        [searchContainer, /*profileButton,*/ titleLabel, currentlyRentedLabel, seeMoreButton,
//         currentlyRentedCollectionView, rentersLabel, rentersCollectionView,
//         suggestedBooksLabel, suggestedBooksCollectionView].forEach {
//            contentView.addSubview($0)
//        }
//        
//        searchContainer.addSubview(searchBar)
//        
//        setupConstraints()
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            
//            searchContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
//            searchContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            searchContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            searchContainer.heightAnchor.constraint(equalToConstant: 50),
//            
//            searchBar.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 8),
//            searchBar.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
//            searchBar.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: -8),
//            
////            profileButton.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
////            profileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
////            profileButton.widthAnchor.constraint(equalToConstant: 40),
////            profileButton.heightAnchor.constraint(equalToConstant: 40),
////            
//            titleLabel.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 30),
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            
//            currentlyRentedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
//            currentlyRentedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            
//            
//            
//            seeMoreButton.centerYAnchor.constraint(equalTo: currentlyRentedLabel.centerYAnchor),
//            seeMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            
//            
//            currentlyRentedCollectionView.topAnchor.constraint(equalTo: currentlyRentedLabel.bottomAnchor, constant: 20),
//            currentlyRentedCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            currentlyRentedCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            currentlyRentedCollectionView.heightAnchor.constraint(equalToConstant: 200),
//            
//            rentersLabel.topAnchor.constraint(equalTo: currentlyRentedCollectionView.bottomAnchor, constant: 30),
//            rentersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            
//            rentersCollectionView.topAnchor.constraint(equalTo: rentersLabel.bottomAnchor, constant: 20),
//            rentersCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            rentersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            rentersCollectionView.heightAnchor.constraint(equalToConstant: 120),
//            
//            suggestedBooksLabel.topAnchor.constraint(equalTo: rentersCollectionView.bottomAnchor, constant: 30),
//            suggestedBooksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            
//            suggestedBooksCollectionView.topAnchor.constraint(equalTo: suggestedBooksLabel.bottomAnchor, constant: 20),
//            suggestedBooksCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            suggestedBooksCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            suggestedBooksCollectionView.heightAnchor.constraint(equalToConstant: 200),
//            suggestedBooksCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
//        ])
//        seeMoreButton.addTarget(self, action: #selector(seemoreButtonTapped), for: .touchUpInside);
//    }
//    
//    private func setupCollectionViews() {
//        currentlyRentedCollectionView.delegate = self
//        currentlyRentedCollectionView.dataSource = self
//        rentersCollectionView.delegate = self
//        rentersCollectionView.dataSource = self
//        suggestedBooksCollectionView.delegate = self
//        suggestedBooksCollectionView.dataSource = self
//        
//        currentlyRentedCollectionView.register(BooksCell.self, forCellWithReuseIdentifier: "BooksCell")
//        rentersCollectionView.register(RenterCell.self, forCellWithReuseIdentifier: "RenterCell")
//        suggestedBooksCollectionView.register(BooksCell.self, forCellWithReuseIdentifier: "BooksCell")
//    }
//}
//
//extension RentHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch collectionView {
//        case currentlyRentedCollectionView:
//            return currentlyRentedBooks.count
//        case rentersCollectionView:
//            return min(renterProfiles.count, renterNames.count)
//        case suggestedBooksCollectionView:
//            return suggestedBooks.count
//        default:
//            return 0
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch collectionView {
//        case currentlyRentedCollectionView:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCell", for: indexPath) as? BooksCell else {
//                return UICollectionViewCell()
//            }
//            let bookID = currentlyRentedBooks[indexPath.item]
//            if let book = getBookByID(bookID) {
//                cell.configure(with: book)
//            }
//            return cell
//            
//        case rentersCollectionView:
//            guard indexPath.item < renterNames.count, indexPath.item < renterProfiles.count else {
//                return UICollectionViewCell()
//            }
//            
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RenterCell", for: indexPath) as? RenterCell else {
//                return UICollectionViewCell()
//            }
//            let name = renterNames[indexPath.item]
//            let image = UIImage(named: renterProfiles[indexPath.item]) ?? UIImage()
//            cell.configure(name: name, image: image)
//            return cell
//            
//        case suggestedBooksCollectionView:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCell", for: indexPath) as? BooksCell else {
//                return UICollectionViewCell()
//            }
//            let bookID = suggestedBooks[indexPath.item]
//            if let book = getBookByID(bookID) {
//                cell.configure(with: book)
//            }
//            return cell
//            
//        default:
//            return UICollectionViewCell()
//        }
//    }
//
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch collectionView {
//        case currentlyRentedCollectionView, suggestedBooksCollectionView:
//            return CGSize(width: 150, height: 200)
//        case rentersCollectionView:
//            return CGSize(width: 100, height: 120)
//        default:
//            return CGSize.zero
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView {
//        case currentlyRentedCollectionView:
//            let bookID = currentlyRentedBooks[indexPath.item]
//            if let book = getBookByID(bookID) {
////                let bookVC = BookViewController(book: book)
////                navigationController?.pushViewController(bookVC, animated: true)
//            }
//            
//        case rentersCollectionView:
//            let renterProfileVC = RentersProfileViewController()
//            renterProfileVC.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(renterProfileVC, animated: true)
//            
//        case suggestedBooksCollectionView:
//            let bookID = suggestedBooks[indexPath.item]
//            if let book = getBookByID(bookID) {
////                let bookVC = BookViewController(book: book)
////                navigationController?.pushViewController(bookVC, animated: true)
//            }
//            
//        default:
//            break
//        }
//    }
//
//}








                    






import UIKit
import FirebaseFirestore

class RentHomeViewController: UIViewController {
    
    private let db = Firestore.firestore()
    private var renters: [(id: String, name: String, profileImage: String?, books: [String])] = []
    private var currentlyRentedBooks: [BookF] = []
    private var suggestedBooks: [BookF] = []
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Rent your next read..."
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .secondarySystemBackground
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rent from your\nCommunity"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let currentlyRentedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Currently Rented"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See more >", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let currentlyRentedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let rentersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Top Renters in your Area"
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let rentersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let suggestedBooksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Books you might like to rent"
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let suggestedBooksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionViews()
        fetchRentersFromFirestore()
        fetchCurrentlyRentedBooks()
        fetchSuggestedBooks()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [searchContainer, titleLabel, currentlyRentedLabel, seeMoreButton,
         currentlyRentedCollectionView, rentersLabel, rentersCollectionView,
         suggestedBooksLabel, suggestedBooksCollectionView].forEach {
            contentView.addSubview($0)
        }
        
        searchContainer.addSubview(searchBar)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            searchContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchContainer.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 8),
            searchBar.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            currentlyRentedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            currentlyRentedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            seeMoreButton.centerYAnchor.constraint(equalTo: currentlyRentedLabel.centerYAnchor),
            seeMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            currentlyRentedCollectionView.topAnchor.constraint(equalTo: currentlyRentedLabel.bottomAnchor, constant: 20),
            currentlyRentedCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            currentlyRentedCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            currentlyRentedCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            rentersLabel.topAnchor.constraint(equalTo: currentlyRentedCollectionView.bottomAnchor, constant: 30),
            rentersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            rentersCollectionView.topAnchor.constraint(equalTo: rentersLabel.bottomAnchor, constant: 20),
            rentersCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rentersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rentersCollectionView.heightAnchor.constraint(equalToConstant: 140),
            
            suggestedBooksLabel.topAnchor.constraint(equalTo: rentersCollectionView.bottomAnchor, constant: 30),
            suggestedBooksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            suggestedBooksCollectionView.topAnchor.constraint(equalTo: suggestedBooksLabel.bottomAnchor, constant: 20),
            suggestedBooksCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            suggestedBooksCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            suggestedBooksCollectionView.heightAnchor.constraint(equalToConstant: 200),
            suggestedBooksCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
    }
    
    private func setupCollectionViews() {
        currentlyRentedCollectionView.delegate = self
        currentlyRentedCollectionView.dataSource = self
        rentersCollectionView.delegate = self
        rentersCollectionView.dataSource = self
        suggestedBooksCollectionView.delegate = self
        suggestedBooksCollectionView.dataSource = self
        
        currentlyRentedCollectionView.register(BooksCell.self, forCellWithReuseIdentifier: "BooksCell")
        rentersCollectionView.register(RenterCell.self, forCellWithReuseIdentifier: "RenterCell")
        suggestedBooksCollectionView.register(BooksCell.self, forCellWithReuseIdentifier: "BooksCell")
    }
    
    // MARK: - Data Fetching Methods
    private func fetchRentersFromFirestore() {
        db.collection("renters").getDocuments { [weak self] snapshot, error in
            guard let self = self, let documents = snapshot?.documents, error == nil else {
                print("Error fetching renters: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.renters = documents.compactMap { document in
                let data = document.data()
                guard let name = data["name"] as? String else { return nil }
                
                let books = (data["rentedBooks"] as? [[String: Any]])?.compactMap { $0["id"] as? String } ?? []
                let profileImage = data["profileImage"] as? String
                
                return (id: document.documentID, name: name, profileImage: profileImage, books: books)
            }
            
            DispatchQueue.main.async {
                self.rentersCollectionView.reloadData()
            }
        }
    }
    
    private func fetchCurrentlyRentedBooks() {
        db.collection("rentedBooks").whereField("status", isEqualTo: "rented").getDocuments { [weak self] snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching rented books: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let bookIDs = documents.compactMap { $0.data()["googleBooksId"] as? String }
            self?.fetchBooksFromGoogleAPI(bookIDs: bookIDs) { books in
                self?.currentlyRentedBooks = books
                DispatchQueue.main.async {
                    self?.currentlyRentedCollectionView.reloadData()
                }
            }
        }
    }
    
    private func fetchSuggestedBooks() {
        // This could be based on user preferences, popular books, or other criteria
        db.collection("books").limit(to: 5).getDocuments { [weak self] snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching suggested books: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let bookIDs = documents.compactMap { $0.data()["googleBooksId"] as? String }
            self?.fetchBooksFromGoogleAPI(bookIDs: bookIDs) { books in
                self?.suggestedBooks = books
                DispatchQueue.main.async {
                    self?.suggestedBooksCollectionView.reloadData()
                }
            }
        }
    }
//    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
//        print("📥 Downloading Image:", url.absoluteString) // Debugging
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("❌ Image Download Error:", error.localizedDescription)
//                completion(nil)
//                return
//            }
//
//            // Check HTTP response
//            if let httpResponse = response as? HTTPURLResponse {
//                print("🔍 HTTP Status Code:", httpResponse.statusCode)
//                if httpResponse.statusCode != 200 {
//                    print("❌ Invalid HTTP Status Code:", httpResponse.statusCode)
//                    completion(nil)
//                    return
//                }
//            }
//
//            // Check image data
//            if let data = data, let image = UIImage(data: data) {
//                print("✅ Image Downloaded Successfully")
//                completion(image)
//            } else {
//                print("❌ Invalid Image Data")
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
    private func fetchBooksFromGoogleAPI(bookIDs: [String], completion: @escaping ([BookF]) -> Void) {
            var books: [BookF] = []
            let group = DispatchGroup()
            
            for id in bookIDs {
                group.enter()
                let urlString = "https://www.googleapis.com/books/v1/volumes/\(id)"
                
                guard let url = URL(string: urlString) else {
                    group.leave()
                    continue
                }
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                    defer { group.leave() }
                    
                    guard let data = data else {
                        print("Error fetching book data: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let book = try decoder.decode(BookF.self, from: data)
                        books.append(book)
                    } catch {
                        print("Error decoding book data: \(error.localizedDescription)")
                    }
                }.resume()
            }
            
            group.notify(queue: .main) {
                completion(books)
            }
        }
    
    // MARK: - Actions
    @objc private func seeMoreButtonTapped() {
        let bookManagementVC = BookManagementViewController()
        navigationController?.pushViewController(bookManagementVC, animated: true)
    }
}

// MARK: - UICollectionView Extensions
extension RentHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case currentlyRentedCollectionView:
            return currentlyRentedBooks.count
        case rentersCollectionView:
            return renters.count
        case suggestedBooksCollectionView:
            return suggestedBooks.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case currentlyRentedCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCell", for: indexPath) as? BooksCell else {
                return UICollectionViewCell()
            }
            let book = currentlyRentedBooks[indexPath.item]
            cell.configure(with: book)
            return cell
            
        case rentersCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RenterCell", for: indexPath) as? RenterCell else {
                return UICollectionViewCell()
            }
            
            let renter = renters[indexPath.item]
            
            if let imageURL = renter.profileImage, let url = URL(string: imageURL) {
                downloadImage(from: url) { image in
                    DispatchQueue.main.async {
                        cell.configure(name: renter.name, image: image ?? UIImage(named: "profile")!)
                    }
                }
            } else {
                cell.configure(name: renter.name, image: UIImage(named: "profile")!)
            }
            return cell
            
        case suggestedBooksCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCell", for: indexPath) as? BooksCell else {
                return UICollectionViewCell()
            }
            let book = suggestedBooks[indexPath.item]
            cell.configure(with: book)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case currentlyRentedCollectionView:
            let book = currentlyRentedBooks[indexPath.item]
            let bookVC = BookViewController(book: book)
            navigationController?.pushViewController(bookVC, animated: true)
            
        case rentersCollectionView:
            let renter = renters[indexPath.item]
            let profileVC = RentersProfileViewController(renterID: renter.id)
            navigationController?.pushViewController(profileVC, animated: true)
            profileVC.hidesBottomBarWhenPushed = true
            
        case suggestedBooksCollectionView:
            let book = suggestedBooks[indexPath.item]
            let bookVC = BookViewController(book: book)
            navigationController?.pushViewController(bookVC, animated: true)
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case currentlyRentedCollectionView, suggestedBooksCollectionView:
            return CGSize(width: 140, height: 200)
        case rentersCollectionView:
            return CGSize(width: 100, height: 140)
        default:
            return CGSize.zero
        }
    }
}

//// MARK: - Helper Methods
//extension RentHomeViewController {
//    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil,
//                  let image = UIImage(data: data) else {
//                completion(nil)
//                return
//            }
//            completion(image)
//        }.resume()
//    }
//}


 
