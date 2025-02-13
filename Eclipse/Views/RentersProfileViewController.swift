
//import UIKit
//
//class RentersProfileViewController: UIViewController {
//    // MARK: - Properties
//    private var regularBooks: [String] = [] {
//        didSet {
//            booksCollectionView.reloadData()
//        }
//    }
//
//    private var collectorsEditionBooks: [String] = []
//
//    private let collectorsStackView: UIStackView = {
//           let stackView = UIStackView()
//           stackView.axis = .horizontal
//           stackView.distribution = .equalSpacing
//           return stackView
//       }()
//
//    private let booksCollectionView: UICollectionView = {
//           let layout = UICollectionViewFlowLayout()
//           layout.scrollDirection = .vertical
//           layout.itemSize = CGSize(width: 100, height: 160)
//           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//           collectionView.register(BookCell.self, forCellWithReuseIdentifier: "BookCell")
//           return collectionView
//       }()
//
//
//    // MARK: - UI Components
//    private let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "profile")
//        imageView.layer.cornerRadius = 30
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "John Doe"
//        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        return label
//    }()
//
//    private let distanceLabel: UILabel = {
//        let label = UILabel()
//        label.text = "5 KM"
//        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
//        label.textColor = UIColor(hex: "005C78")
//        return label
//    }()
//
//    private let ratingButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("4.0", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
//        button.setTitleColor(UIColor(hex: "005C78"), for: .normal)
//        return button
//    }()
//
//    private let starImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "star.fill")
//        imageView.tintColor = UIColor(hex: "005C78")
//        return imageView
//    }()
//
//    private let chatButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
//        button.backgroundColor = .clear
//        button.layer.cornerRadius = 15
//        button.tintColor = UIColor(hex: "005C78")
//        return button
//    }()
//
//    private let collectorsEditionLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Collectors Edition"
//        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
//        label.textColor = UIColor(hex: "B19065")
//        return label
//    }()
//
//    private let collectorsContainer: UIView = {
//        let view = UIView()
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [
//            UIColor(hex: "D4BC86").cgColor,
//            UIColor(hex: "B19065").cgColor
//        ]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        view.layer.insertSublayer(gradientLayer, at: 0)
//        view.layer.cornerRadius = 20
//        view.clipsToBounds = true
//        return view
//    }()
//
//
//
//    // MARK: - Lifecycle Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "John Doe"
//        navigationItem.largeTitleDisplayMode = .never
//        view.backgroundColor = .white
//        booksCollectionView.dataSource = self
//        booksCollectionView.delegate = self
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            title: "< Back",
//            style: .plain,
//            target: self,
//            action: #selector(backButtonTapped)
//        )
//        setupUI()
//        setupNotifications()
//        loadRentedBooks()
//        loadCollectorsBooks()
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    // MARK: - Setup Methods
//    private func setupUI() {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
//        view.addSubview(headerView)
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//
//        setupHeaderConstraints(headerView)
//        setupCollectorsSection()
//        setupBooksCollection()
//    }
//
//    private func setupHeaderConstraints(_ headerView: UIView) {
//        [profileImageView, nameLabel, distanceLabel, ratingButton, starImageView, chatButton].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            headerView.addSubview($0)
//        }
//
//        NSLayoutConstraint.activate([
//            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            headerView.heightAnchor.constraint(equalToConstant: 100),
//
//            profileImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//            profileImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            profileImageView.widthAnchor.constraint(equalToConstant: 60),
//            profileImageView.heightAnchor.constraint(equalToConstant: 60),
//
//            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
//            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
//
//            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
//            distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
//
//            ratingButton.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor, constant: 16),
//            ratingButton.centerYAnchor.constraint(equalTo: distanceLabel.centerYAnchor),
//
//            starImageView.leadingAnchor.constraint(equalTo: ratingButton.trailingAnchor, constant: 4),
//            starImageView.centerYAnchor.constraint(equalTo: ratingButton.centerYAnchor),
//            starImageView.widthAnchor.constraint(equalToConstant: 16),
//            starImageView.heightAnchor.constraint(equalToConstant: 16),
//
//            chatButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
//            chatButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
//            chatButton.widthAnchor.constraint(equalToConstant: 30),
//            chatButton.heightAnchor.constraint(equalToConstant: 30)
//        ])
//
//        ratingButton.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
//        chatButton.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
//    }
//
//    private func setupCollectorsSection() {
//        [collectorsContainer, collectorsEditionLabel].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview($0)
//        }
//
//        collectorsStackView.translatesAutoresizingMaskIntoConstraints = false
//        collectorsContainer.addSubview(collectorsStackView)
//
//        NSLayoutConstraint.activate([
//            collectorsEditionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 124),
//            collectorsEditionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//
//            collectorsContainer.topAnchor.constraint(equalTo: collectorsEditionLabel.bottomAnchor, constant: 16),
//            collectorsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            collectorsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            collectorsContainer.heightAnchor.constraint(equalToConstant: 200),
//
//            collectorsStackView.topAnchor.constraint(equalTo: collectorsContainer.topAnchor, constant: 20),
//            collectorsStackView.leadingAnchor.constraint(equalTo: collectorsContainer.leadingAnchor, constant: 20),
//            collectorsStackView.trailingAnchor.constraint(equalTo: collectorsContainer.trailingAnchor, constant: -20),
//            collectorsStackView.bottomAnchor.constraint(equalTo: collectorsContainer.bottomAnchor, constant: -20)
//        ])
//
//        setupCollectorsBooks()
//    }
//
//
//
//    private func setupCollectorsBooks() {
//        collectorsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
//
//        for bookID in collectorsEditionBooks {
//            let bookImageView = UIImageView()
//            let book = getBookByID(bookID)
//            bookImageView.image = book?.coverImageURL
//            bookImageView.contentMode = .scaleAspectFill
//            bookImageView.layer.cornerRadius = 10
//            bookImageView.clipsToBounds = true
//            bookImageView.backgroundColor = .white
//            bookImageView.isUserInteractionEnabled = true // Enable interaction
//
//            // Add Tap Gesture to Navigate to Book Page
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBookTap(_:)))
//            bookImageView.addGestureRecognizer(tapGesture)
//            tapGesture.name = bookID
//
//            // Add Long Press Gesture to Remove Book
//            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleBookLongPress(_:)))
//            bookImageView.addGestureRecognizer(longPressGesture)
//            longPressGesture.name = bookID
//
//            collectorsStackView.addArrangedSubview(bookImageView)
//
//            NSLayoutConstraint.activate([
//                bookImageView.widthAnchor.constraint(equalToConstant: 100),
//                bookImageView.heightAnchor.constraint(equalToConstant: 150)
//            ])
//        }
//    }
//
//
//    private func setupBooksCollection() {
//        booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(booksCollectionView)
//
//        NSLayoutConstraint.activate([
//            booksCollectionView.topAnchor.constraint(equalTo: collectorsContainer.bottomAnchor, constant: 16),
//            booksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            booksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            booksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    private func loadCollectorsBooks() {
//          collectorsEditionBooks = UserDefaults.standard.array(forKey: "collectorsBooks") as? [String] ?? []
//          setupCollectorsBooks()
//      }
//
//    // MARK: - Actions and Notifications
//    private func setupNotifications() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(handleBookAdded(_:)),
//            name: NSNotification.Name("BookAddedToProfile"),
//            object: nil
//        )
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(handleCollectorsBookRemoved(_:)),
//            name: NSNotification.Name("CollectorsBookRemoved"),
//            object: nil
//        )
//
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(handleBookRemoved(_:)),
//            name: NSNotification.Name("BookRemovedFromProfile"),
//            object: nil
//        )
//    }
//
//    @objc private func loadRentedBooks() {
//        regularBooks = UserDefaults.standard.array(forKey: "rentedBooks") as? [String] ?? []
//    }
//    // 📖 Navigate to Book Page when tapped
//    @objc private func handleBookTap(_ sender: UITapGestureRecognizer) {
//        guard let bookID = sender.name, let book = getBookByID(bookID) else { return }
//
////        let bookVC = BookViewController(book: book)
////        navigationController?.pushViewController(bookVC, animated: true)
//    }
//
//
//    @objc private func handleBookLongPress(_ sender: UILongPressGestureRecognizer) {
//        guard let bookID = sender.name, let index = collectorsEditionBooks.firstIndex(of: bookID) else { return }
//
//        let alert = UIAlertController(
//            title: "Remove Book",
//            message: "Do you want to remove this book from your Collector's Edition?",
//            preferredStyle: .alert
//        )
//
//        alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
//            self?.collectorsEditionBooks.remove(at: index)
//            UserDefaults.standard.set(self?.collectorsEditionBooks, forKey: "collectorsBooks")
//
//            // Update UI Dynamically
//            self?.setupCollectorsBooks()
//        })
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//
//        present(alert, animated: true)
//    }
//
//    @objc private func handleBookAdded(_ notification: Notification) {
//        guard let bookId = notification.userInfo?["bookId"] as? String else { return }
//
//        if !regularBooks.contains(bookId) {
//            regularBooks.append(bookId)
//            UserDefaults.standard.set(regularBooks, forKey: "rentedBooks")
//
//            // ✅ FIX: Reload the collection view to prevent mismatch errors
//            booksCollectionView.reloadData()
//        }
//    }
//
//
//
//
//    @objc private func handleCollectorsBookAdded(_ notification: Notification) {
//          guard let bookId = notification.userInfo?["bookId"] as? String else { return }
//          if !collectorsEditionBooks.contains(bookId) {
//              collectorsEditionBooks.append(bookId)
//              setupCollectorsBooks()
//          }
//      }
//    @objc private func handleCollectorsBookRemoved(_ notification: Notification) {
//            guard let bookId = notification.userInfo?["bookId"] as? String,
//                  let index = collectorsEditionBooks.firstIndex(of: bookId) else { return }
//
//            collectorsEditionBooks.remove(at: index)
//            UserDefaults.standard.set(collectorsEditionBooks, forKey: "collectorsBooks")
//            setupCollectorsBooks()
//        }
//
//
//    @objc private func handleBookRemoved(_ notification: Notification) {
//        guard let bookId = notification.userInfo?["bookId"] as? String else { return }
//
//        if let index = regularBooks.firstIndex(of: bookId) {
//            regularBooks.remove(at: index)
//            UserDefaults.standard.set(regularBooks, forKey: "rentedBooks")
//
//            // ✅ FIX: Reload data instead of batch updates
//            booksCollectionView.reloadData()
//        }
//    }
//
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//
//    @objc private func ratingButtonTapped() {
//        let ratingPopup = RatingPopupView { [weak self] rating in
//            self?.ratingButton.setTitle(String(format: "%.1f", Float(rating)), for: .normal)
//        }
//        ratingPopup.frame = view.bounds
//        view.addSubview(ratingPopup)
//    }
//
//    @objc private func chatButtonTapped() {
//        let chatVC = ChatViewController()
//        chatVC.title = nameLabel.text
//        navigationController?.pushViewController(chatVC, animated: true)
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        if let gradientLayer = collectorsContainer.layer.sublayers?.first as? CAGradientLayer {
//            gradientLayer.frame = collectorsContainer.bounds
//        }
//    }
//}
//
//// MARK: - UICollectionView DataSource & Delegate
//extension RentersProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return regularBooks.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
//
//        let bookId = regularBooks[indexPath.item]
//        if let book = getBookByID(bookId) {
//            cell.configure(with: book)
//        }
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        if collectionView == self.booksCollectionView{
//            let selectedBookId = regularBooks[indexPath.item]
//            if let selectedBook = getBookByID(selectedBookId) {
////                let bookVC = BookViewController(book: selectedBook)
////                navigationController?.pushViewController(bookVC, animated: true)
//            } else {
//                print("Book not found for ID: \(selectedBookId)")
//            }
//        }
//    }
//}








import UIKit
import Firebase
import FirebaseAuth

class RentersProfileViewController: UIViewController {

    // MARK: - Properties
    private var rentedBooks: [BookF] = [] {
        didSet {
            booksCollectionView.reloadData()
        }
    }
    private let db = Firestore.firestore()
    private let renterID: String

    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(hex: "005C78")
        return label
    }()

    private let ratingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("4.0", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.setTitleColor(UIColor(hex: "005C78"), for: .normal)
        return button
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor(hex: "005C78")
        return imageView
    }()

    private let chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.tintColor = UIColor(hex: "005C78")
        return button
    }()

    private lazy var booksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 48) / 2, height: 240)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: "BookCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Initialization
    init(renterID: String) {
        self.renterID = renterID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchRenterDetails()
        fetchRentedBooks()
        setupNotifications()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never

        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        setupHeaderConstraints(headerView)
        setupBooksCollection()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "< Back",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }

    private func setupHeaderConstraints(_ headerView: UIView) {
        [profileImageView, nameLabel, distanceLabel, ratingButton, starImageView, chatButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),

            profileImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),

            ratingButton.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor, constant: 3),
            ratingButton.centerYAnchor.constraint(equalTo: distanceLabel.centerYAnchor),

            starImageView.leadingAnchor.constraint(equalTo: ratingButton.trailingAnchor, constant: 4),
            starImageView.centerYAnchor.constraint(equalTo: ratingButton.centerYAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16),

            chatButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            chatButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            chatButton.widthAnchor.constraint(equalToConstant: 30),
            chatButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        ratingButton.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
        chatButton.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
    }

    private func setupBooksCollection() {
        booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(booksCollectionView)

        NSLayoutConstraint.activate([
            booksCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 116),
            booksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            booksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            booksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchRenterDetails() {
        print("fetchRenterDetails() called")  // Step 1: Confirm function is being called
        
        guard !renterID.isEmpty else {
            print("Error: renterID is empty")
            return
        }

        print("Fetching details for renterID: \(renterID)")  // Step 2: Confirm renterID exists

        db.collection("renters").document(renterID).getDocument { [weak self] snapshot, error in
            guard let self = self else {
                print("Self is nil inside Firestore closure")
                return
            }

            if let error = error {
                print("Error fetching renter details: \(error.localizedDescription)")
                return
            }

            guard let data = snapshot?.data() else {
                print("Firestore returned no data for renterID: \(renterID)")
                return
            }

            print("Fetched data: \(data)")  // Step 3: Check if Firestore is returning anything

            guard let name = data["name"] as? String else {
                print("Missing fields in Firestore data")
                return
            }

            DispatchQueue.main.async {
                self.nameLabel.text = name
                self.navigationItem.title = name

                print("Updated UI with Name: \(name)")
            }
        }
    }


    private func fetchRentedBooks() {
        db.collection("renters").document(renterID).getDocument { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching rented books: \(error)")
                return
            }

            guard let snapshot = snapshot,
                  let data = snapshot.data(),
                  let rentedBooksArray = data["rentedBooks"] as? [[String: Any]] else {
                print("No rented books found")
                return
            }

            let bookIDs = rentedBooksArray.compactMap { $0["id"] as? String }
            self?.fetchBooksFromGoogleAPI(bookIDs: bookIDs)
        }
    }

        private func fetchBooksFromGoogleAPI(bookIDs: [String]) {
            let group = DispatchGroup()
            var books: [BookF] = []

            for bookID in bookIDs {
                group.enter()
                let urlString = "https://www.googleapis.com/books/v1/volumes/\(bookID)"
                guard let url = URL(string: urlString) else {
                    print("Invalid URL for book ID: \(bookID)")
                    group.leave()
                    continue
                }

                URLSession.shared.dataTask(with: url) { data, _, error in
                    defer { group.leave() }

                    if let error = error {
                        print("Error fetching book data: \(error)")
                        return
                    }

                    guard let data = data else {
                        print("No data received for book ID: \(bookID)")
                        return
                    }

                    do {
                        let bookData = try JSONDecoder().decode(GoogleBookResponse.self, from: data)
                        if let book = bookData.toBookF() {
                            books.append(book)
                        }
                    } catch {
                        print("Error decoding book data: \(error)")
                    }
                }.resume()
            }

        group.notify(queue: .main) { [weak self] in
            self?.rentedBooks = books
        }
    }

    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func ratingButtonTapped() {
        let ratingPopup = RatingPopupView { [weak self] rating in
            self?.ratingButton.setTitle(String(format: "%.1f", Float(rating)), for: .normal)
        }
        ratingPopup.frame = view.bounds
        view.addSubview(ratingPopup)
    }

    @objc private func chatButtonTapped() {
        let chatVC = ChatViewController()
        chatVC.title = nameLabel.text
        navigationController?.pushViewController(chatVC, animated: true)
    }

    // MARK: - Notifications
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleBookAdded(_:)),
            name: NSNotification.Name("BookAddedToProfile"),
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleBookRemoved(_:)),
            name: NSNotification.Name("BookRemovedFromProfile"),
            object: nil
        )
    }

    @objc private func handleBookAdded(_ notification: Notification) {
        fetchRentedBooks()
    }

    @objc private func handleBookRemoved(_ notification: Notification) {
        fetchRentedBooks()
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension RentersProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rentedBooks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        let book = rentedBooks[indexPath.item]
        cell.configure(with: book)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = rentedBooks[indexPath.item]
        let bookVC = BookViewController(book: selectedBook)
        navigationController?.pushViewController(bookVC, animated: true)
    }
}
struct GoogleBookResponse: Codable {
    let id: String
    let volumeInfo: VolumeInfo

    struct VolumeInfo: Codable {
        let title: String
        let authors: [String]?
        let description: String?
        let pageCount: Int?
        let averageRating: Double?
        let ratingsCount: Int?
        let imageLinks: ImageLinks?
        let previewLink: String?
    }

    func toBookF() -> BookF? {
        return BookF(
            id: id,
            title: volumeInfo.title,
            subtitle: "",
            authors: volumeInfo.authors ?? [],
            description: volumeInfo.description ?? "",
            averageRating: volumeInfo.averageRating ?? 0,
            ratingsCount: volumeInfo.ratingsCount ?? 0,
            imageLinks: ImageLinks(
                smallThumbnail: volumeInfo.imageLinks?.smallThumbnail,
                thumbnail: volumeInfo.imageLinks?.thumbnail
            ),
            previewLink: volumeInfo.previewLink ?? "",
            pageCount: volumeInfo.pageCount ?? 0
        )
    }
}





