import UIKit
import FirebaseFirestore

// Custom NotificationBanner class implementation
class NotificationBanner {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "005C78")
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(message: String) {
        messageLabel.text = message
    }
    
    func show(in view: UIView) {
        containerView.addSubview(messageLabel)
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(translationX: 0, y: -20)
        
        UIView.animate(withDuration: 0.3) {
            self.containerView.alpha = 1
            self.containerView.transform = .identity
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.3) {
                self.containerView.alpha = 0
                self.containerView.transform = CGAffineTransform(translationX: 0, y: -20)
            } completion: { _ in
                self.containerView.removeFromSuperview()
            }
        }
    }
}

class BookViewController: UIViewController {
    // MARK: - Properties
    var book: BookF?
    private let db = Firestore.firestore()
    private var customLists: [String] = []
    private var isBookAdded: Bool = false {
        didSet {
            updateAddButtonAppearance()
        }
    }

    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(hex: "#666666")
        return button
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()

    private let ratingView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 4
        sv.alignment = .center
        return sv
    }()

    private let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 16
        sv.alignment = .center
        return sv
    }()

    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(UIColor(hex: "005C78"), for: .normal)
        button.layer.borderColor = UIColor(hex: "005C78").cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()

    private let rentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rent", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "005C78")
        button.layer.cornerRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    init(book: BookF) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        checkIfBookIsAdded()
        buyButton.addTarget(self, action: #selector(navigateToRentersNearby), for: .touchUpInside)
        rentButton.addTarget(self, action: #selector(navigateToRentersNearby), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    // MARK: - Setup and Configuration
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = book?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bookmarkButton)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [bookImageView, ratingView, descriptionLabel, buttonStackView].forEach { contentView.addSubview($0) }

        for _ in 0..<5 {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.tintColor = .systemGray
            ratingView.addArrangedSubview(starImageView)
        }

        buttonStackView.addArrangedSubview(buyButton)
        buttonStackView.addArrangedSubview(rentButton)

        setupConstraints()
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            bookImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookImageView.widthAnchor.constraint(equalToConstant: 200),
            bookImageView.heightAnchor.constraint(equalToConstant: 300),

            ratingView.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 12),
            ratingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            buttonStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            buttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func configureUI() {
        guard let book = book else { return }

        if let imageUrl = book.imageLinks?.thumbnail, let url = URL(string: imageUrl) {
            loadImage(from: url)
        } else {
            bookImageView.image = UIImage(systemName: "book.fill")
        }

        descriptionLabel.text = book.description

        for (index, star) in ratingView.arrangedSubviews.enumerated() {
            if index < Int(book.averageRating ?? 0) {
                (star as? UIImageView)?.tintColor = .systemYellow
            } else {
                (star as? UIImageView)?.tintColor = .systemGray
            }
        }
    }

    // MARK: - Helper Methods
    private func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.bookImageView.image = UIImage(systemName: "book.fill")
                }
                return
            }

            guard let data = data, let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self?.bookImageView.image = image
            }
        }
        task.resume()
    }

    private func checkIfBookIsAdded() {
        guard let book = book else { return }
        let regularBooks = UserDefaults.standard.array(forKey: "rentedBooks") as? [String] ?? []
        let collectorsBooks = UserDefaults.standard.array(forKey: "collectorsBooks") as? [String] ?? []
        isBookAdded = regularBooks.contains(book.id) || collectorsBooks.contains(book.id)
    }

    private func updateAddButtonAppearance() {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        let image = isBookAdded ?
            UIImage(systemName: "checkmark", withConfiguration: symbolConfig) :
            UIImage(systemName: "plus", withConfiguration: symbolConfig)
        
        addButton.setImage(image, for: .normal)
        addButton.tintColor = isBookAdded ? UIColor(hex: "#005C78") : UIColor(hex: "#666666")
    }

    // MARK: - Actions
    @objc private func bookmarkButtonTapped() {
        guard let book = book else { return }

        let addToLibraryVC = AddToLibraryViewController()
        addToLibraryVC.book = book

        let navController = UINavigationController(rootViewController: addToLibraryVC)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: true, completion: nil)
    }
    
    @objc private func navigateToRentersNearby(sender: UIButton) {
        let rentersNearbyVC = RentersNearbyViewController()
        navigationController?.pushViewController(rentersNearbyVC, animated: true)
    }
    
    @objc private func addButtonTapped() {
        if !isBookAdded {
            showCollectorsEditionAlert()
        } else {
            removeBook()
        }
    }
    
    private func showCollectorsEditionAlert() {
        let alert = UIAlertController(
            title: "Book Type",
            message: "Is this a Collector's Edition book?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.addBook(isCollectorsEdition: true)
        })
        
        alert.addAction(UIAlertAction(title: "No", style: .default) { [weak self] _ in
            self?.addBook(isCollectorsEdition: false)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func addBook(isCollectorsEdition: Bool) {
        guard var book = book else { return }
//        book.isCollectorsEdition = isCollectorsEdition
        
        let key = isCollectorsEdition ? "collectorsBooks" : "rentedBooks"
        var books = UserDefaults.standard.array(forKey: key) as? [String] ?? []
        
        if !books.contains(book.id) {
            books.append(book.id)
            UserDefaults.standard.set(books, forKey: key)
            isBookAdded = true
            
            // Show feedback and notification
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.impactOccurred()
            
            // Visual feedback
            UIView.animate(withDuration: 0.3) {
                self.addButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.addButton.transform = .identity
                }
            }
            
            // Show notification banner
            let notificationBanner = NotificationBanner(message: "\(book.title) added to your \(isCollectorsEdition ? "collector's" : "") profile")
            notificationBanner.show(in: self.view)
            
            // Notify RentersProfileViewController
            NotificationCenter.default.post(
                name: NSNotification.Name(isCollectorsEdition ? "CollectorsBookAdded" : "BookAddedToProfile"),
                object: nil,
                userInfo: ["bookId": book.id]
            )
        }
    }
    
    private func removeBook() {
        guard let book = book else { return }
        
        // Check both regular and collectors books
        var regularBooks = UserDefaults.standard.array(forKey: "rentedBooks") as? [String] ?? []
        var collectorsBooks = UserDefaults.standard.array(forKey: "collectorsBooks") as? [String] ?? []
        
        if regularBooks.contains(book.id) {
            regularBooks.removeAll { $0 == book.id }
            UserDefaults.standard.set(regularBooks, forKey: "rentedBooks")
            NotificationCenter.default.post(
                name: NSNotification.Name("BookRemovedFromProfile"),
                object: nil,
                userInfo: ["bookId": book.id]
            )
        }
        
        if collectorsBooks.contains(book.id) {
            collectorsBooks.removeAll { $0 == book.id }
            UserDefaults.standard.set(collectorsBooks, forKey: "collectorsBooks")
            NotificationCenter.default.post(
                name: NSNotification.Name("CollectorsBookRemoved"),
                object: nil,
                userInfo: ["bookId": book.id]
            )
        }
        
        isBookAdded = false
        
        // Show notification banner
        let notificationBanner = NotificationBanner(message: "\(book.title) removed from your profile")
        notificationBanner.show(in: self.view)
        
        // Haptic feedback
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
        
        // Visual shake animation
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -8.0, 8.0, -5.0, 5.0, 0.0]
        addButton.layer.add(animation, forKey: "shake")
    }
}

// MARK: - UIColor Extension
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
