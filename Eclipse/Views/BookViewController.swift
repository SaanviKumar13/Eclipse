import UIKit
import FirebaseFirestore

class BookViewController: UIViewController {

    var book: BookF?
    private let db = Firestore.firestore()
    private var customLists: [String] = []

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
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
        buyButton.addTarget(self, action: #selector(navigateToRentersNearby), for: .touchUpInside)
        rentButton.addTarget(self, action: #selector(navigateToRentersNearby), for: .touchUpInside)
    }

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

        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
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
        rentersNearbyVC.selectedBook = book
        rentersNearbyVC.actionType = sender == buyButton ? "Buy" : "Rent"
        navigationController?.pushViewController(rentersNearbyVC, animated: true)
    }
}

