//  Created by admin48 on 18/11/24.
//
//import FirebaseFirestore
//
//private let db = Firestore.firestore()
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
//    private let profileButton: UIButton = {
//        let button = UIButton()
//        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
//        let image = UIImage(named: "profile")
//        button.setImage(image, for: .normal)
//        button.tintColor = .systemBlue
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
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
//    private var currentlyRentedBooks = ["4", "9"]
//    private var renterProfiles = ["profile", "profile", "profile", "profile", "profile"]
//    private var renterNames = ["Sara\nMukhija", "Dhruv\nSharma", "Ananya\nSharma", "Raj\nVerma"]
//    private var suggestedBooks = ["13", "17", "12", "11", "19"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupCollectionViews()
//
//        loadRentedBooks()
//        loadTopRenters()
//        loadSuggestedBooks()
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
//        [searchContainer, profileButton, titleLabel, currentlyRentedLabel, seeMoreButton,
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
//    private func loadRentedBooks() {
//        db.collection("rentedBooks").getDocuments { (snapshot, error) in
//            if let error = error {
//                print("❌ Error fetching rented books: \(error)")
//                return
//            }
//
//            self.currentlyRentedBooks = snapshot?.documents.compactMap { $0.documentID } ?? []
//
//            DispatchQueue.main.async {
//                self.currentlyRentedCollectionView.reloadData()
//            }
//        }
//    }
//    private func loadTopRenters() {
//        db.collection("renters").order(by: "rating", descending: true).getDocuments { (snapshot, error) in
//            if let error = error {
//                print("❌ Error fetching renters: \(error)")
//                return
//            }
//
//            self.renterProfiles = []
//            self.renterNames = []
//
//            for document in snapshot!.documents {
//                if let name = document.data()["name"] as? String,
//                   let profileImageURL = document.data()["profileImageURL"] as? String {
//                    self.renterNames.append(name)
//                    self.renterProfiles.append(profileImageURL) // Store URL instead of local image
//                }
//            }
//
//            DispatchQueue.main.async {
//                self.rentersCollectionView.reloadData()
//            }
//        }
//    }
//    private func loadSuggestedBooks() {
//        db.collection("suggestedBooks").getDocuments { (snapshot, error) in
//            if let error = error {
//                print("❌ Error fetching suggested books: \(error)")
//                return
//            }
//
//            self.suggestedBooks = snapshot?.documents.compactMap { $0.documentID } ?? []
//
//            DispatchQueue.main.async {
//                self.suggestedBooksCollectionView.reloadData()
//            }
//        }
//    }
//
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
//            searchBar.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -8),
//
//            profileButton.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
//            profileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            profileButton.widthAnchor.constraint(equalToConstant: 40),
//            profileButton.heightAnchor.constraint(equalToConstant: 40),
//
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
//
//    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
//        guard let url = URL(string: urlString), !urlString.isEmpty else {
//            print("❌ Invalid URL: \(urlString)")
//            completion(UIImage(named: "defaultProfile")) // Provide a default image
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print("❌ Error loading image: \(error)")
//                completion(UIImage(named: "defaultProfile")) // Provide a default image if error occurs
//                return
//            }
//
//            if let data = data, let image = UIImage(data: data) {
//                completion(image)
//            } else {
//                print("❌ Failed to create image from data")
//                completion(UIImage(named: "defaultProfile")) // Provide a default image if data is nil
//            }
//        }.resume()
//    }
//
//
//
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
//                print("❌ Failed to dequeue RenterCell")
//                return UICollectionViewCell()
//            }
//
//
//            let name = renterNames[indexPath.item]
//            let imageURL = renterProfiles[indexPath.item]
//
//            // Load image asynchronously
//            loadImage(from: imageURL) { image in
//                DispatchQueue.main.async {
//                    cell.configure(name: name, image: image ?? UIImage(named: "defaultProfile")!)
//                }
//            }
//
//
//
//            return cell
//
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
//                let bookVC = BookViewController(book: book)
//                navigationController?.pushViewController(bookVC, animated: true)
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
//                let bookVC = BookViewController(book: book)
//                navigationController?.pushViewController(bookVC, animated: true)
//            }
//
//        default:
//            break
//        }
//    }
//
//}
import UIKit

class RentHomeViewController: UIViewController {

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
    
    private let profileButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        let image = UIImage(named: "profile")
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

    private let currentlyRentedBooks = ["4", "9"]
    private let renterProfiles = ["profile", "profile", "profile", "profile", "profile"]
    private let renterNames = ["Sara\nMukhija", "Dhruv\nSharma", "Ananya\nSharma", "Raj\nVerma"]
    private let suggestedBooks = ["13", "17", "12", "11", "19"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionViews()
    }
    
    @objc private func seemoreButtonTapped() {
        let chattVC = BookManagementViewController()

        navigationController?.pushViewController(chattVC, animated: true)
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        view.addSubview(seeMoreButton)
        scrollView.addSubview(contentView)
        
        [searchContainer, profileButton, titleLabel, currentlyRentedLabel, seeMoreButton,
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
            searchBar.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -8),
            
            profileButton.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            profileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            
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
            rentersCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            suggestedBooksLabel.topAnchor.constraint(equalTo: rentersCollectionView.bottomAnchor, constant: 30),
            suggestedBooksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            suggestedBooksCollectionView.topAnchor.constraint(equalTo: suggestedBooksLabel.bottomAnchor, constant: 20),
            suggestedBooksCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            suggestedBooksCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            suggestedBooksCollectionView.heightAnchor.constraint(equalToConstant: 200),
            suggestedBooksCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        seeMoreButton.addTarget(self, action: #selector(seemoreButtonTapped), for: .touchUpInside);
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
}

extension RentHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case currentlyRentedCollectionView:
            return currentlyRentedBooks.count
        case rentersCollectionView:
            return min(renterProfiles.count, renterNames.count)
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
            let bookID = currentlyRentedBooks[indexPath.item]
            if let book = getBookByID(bookID) {
                cell.configure(with: book)
            }
            return cell
            
        case rentersCollectionView:
            guard indexPath.item < renterNames.count, indexPath.item < renterProfiles.count else {
                return UICollectionViewCell()
            }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RenterCell", for: indexPath) as? RenterCell else {
                return UICollectionViewCell()
            }
            let name = renterNames[indexPath.item]
            let image = UIImage(named: renterProfiles[indexPath.item]) ?? UIImage()
            cell.configure(name: name, image: image)
            return cell
            
        case suggestedBooksCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCell", for: indexPath) as? BooksCell else {
                return UICollectionViewCell()
            }
            let bookID = suggestedBooks[indexPath.item]
            if let book = getBookByID(bookID) {
                cell.configure(with: book)
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case currentlyRentedCollectionView, suggestedBooksCollectionView:
            return CGSize(width: 150, height: 200)
        case rentersCollectionView:
            return CGSize(width: 100, height: 120)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case currentlyRentedCollectionView:
            let bookID = currentlyRentedBooks[indexPath.item]
            if let book = getBookByID(bookID) {
//                let bookVC = BookViewController(book: book)
//                navigationController?.pushViewController(bookVC, animated: true)
            }
            
        case rentersCollectionView:
            let renterProfileVC = RentersProfileViewController()
            renterProfileVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(renterProfileVC, animated: true)
            
        case suggestedBooksCollectionView:
            let bookID = suggestedBooks[indexPath.item]
            if let book = getBookByID(bookID) {
//                let bookVC = BookViewController(book: book)
//                navigationController?.pushViewController(bookVC, animated: true)
            }
            
        default:
            break
        }
    }

}
