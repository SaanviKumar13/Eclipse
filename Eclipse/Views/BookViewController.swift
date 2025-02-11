

//
//
//import UIKit
//
//
//
//// MARK: - Book View Controller
//class BookViewController: UIViewController {
//    var book: Book?
//    private var isBookAdded: Bool = false {
//        didSet {
//            updateAddButtonAppearance()
//        }
//    }
//    
//    private let addButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(systemName: "plus"), for: .normal)
//        button.tintColor = UIColor(hex: "#666666")
//        return button
//    }()
//    
//    private let scrollView: UIScrollView = {
//        let sv = UIScrollView()
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        return sv
//    }()
//    
//    private let contentView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let bookImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.contentMode = .scaleAspectFit
//        iv.layer.cornerRadius = 12
//        iv.clipsToBounds = true
//        iv.layer.shadowColor = UIColor.black.cgColor
//        iv.layer.shadowOffset = CGSize(width: 0, height: 4)
//        iv.layer.shadowOpacity = 0.3
//        iv.layer.shadowRadius = 5
//        return iv
//    }()
//    
//    private let descriptionLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 16)
//        label.numberOfLines = 0
//        label.textColor = .darkGray
//        return label
//    }()
//    
//    private let ratingView: UIStackView = {
//        let sv = UIStackView()
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.axis = .horizontal
//        sv.spacing = 4
//        sv.alignment = .center
//        return sv
//    }()
//    
//    private let buyButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Buy for $19.99", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
//        button.backgroundColor = UIColor(hex: "#005C78")
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 12
//        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        return button
//    }()
//    
//    private let rentButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Rent for $4.99", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
//        button.backgroundColor = .clear
//        button.setTitleColor(UIColor(hex: "#005C78"), for: .normal)
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor(hex: "#005C78").cgColor
//        button.layer.cornerRadius = 12
//        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        return button
//    }()
//    
//    private let buttonStackView: UIStackView = {
//        let sv = UIStackView()
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.axis = .horizontal
//        sv.spacing = 16
//        sv.alignment = .center
//        return sv
//    }()
//    
//    init(book: Book) {
//        self.book = book
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        configureUI()
//        setupNavigationBar()
//        checkIfBookIsAdded()
//    }
//    
//    private func setupNavigationBar() {
//        navigationItem.title = book?.title
//        let addBarButton = UIBarButtonItem(customView: addButton)
//        navigationItem.rightBarButtonItem = addBarButton
//        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//    }
//    
//    private func checkIfBookIsAdded() {
//        guard let book = book else { return }
//        let rentedBooks = UserDefaults.standard.array(forKey: "rentedBooks") as? [String] ?? []
//        isBookAdded = rentedBooks.contains(book.id)
//    }
//    
//    private func updateAddButtonAppearance() {
//        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
//        let image = isBookAdded ?
//            UIImage(systemName: "checkmark", withConfiguration: symbolConfig) :
//            UIImage(systemName: "plus", withConfiguration: symbolConfig)
//        
//        addButton.setImage(image, for: .normal)
//        addButton.tintColor = isBookAdded ? UIColor(hex: "#005C78") : UIColor(hex: "#666666")
//    }
//    
//    @objc private func addButtonTapped() {
//        guard let book = book else { return }
//        
//        var rentedBooks = UserDefaults.standard.array(forKey: "rentedBooks") as? [String] ?? []
//        
//        // Show feedback and notification for both adding and removing
//        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
//        feedbackGenerator.impactOccurred()
//        
//        // Visual feedback animation
//        UIView.animate(withDuration: 0.3) {
//            self.addButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//        } completion: { _ in
//            UIView.animate(withDuration: 0.2) {
//                self.addButton.transform = .identity
//            }
//        }
//        
//        if !rentedBooks.contains(book.id) {
//            // Add book
//            rentedBooks.append(book.id)
//            UserDefaults.standard.set(rentedBooks, forKey: "rentedBooks")
//            isBookAdded = true
//            
//            // Notify RentersProfileViewController to update UI
//            NotificationCenter.default.post(
//                name: NSNotification.Name("BookAddedToProfile"),
//                object: nil,
//                userInfo: ["bookId": book.id]
//            )
//            
//            // Show "Added" notification banner
//            let notificationBanner = NotificationBanner(message: "\(book.title) added to your profile")
//            notificationBanner.show(in: self.view)
//        } else {
//            // Remove book
//            rentedBooks.removeAll { $0 == book.id }
//            UserDefaults.standard.set(rentedBooks, forKey: "rentedBooks")
//            isBookAdded = false
//            
//            // Show "Removed" notification banner
//            let notificationBanner = NotificationBanner(message: "\(book.title) removed from your profile")
//            notificationBanner.show(in: self.view)
//            
//            // Notify RentersProfileViewController to update UI
//            NotificationCenter.default.post(
//                name: NSNotification.Name("BookRemovedFromProfile"),
//                object: nil,
//                userInfo: ["bookId": book.id]
//            )
//        }
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .systemBackground
//        
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        
//        [bookImageView, ratingView, descriptionLabel, buttonStackView].forEach { contentView.addSubview($0) }
//        buttonStackView.addArrangedSubview(buyButton)
//        buttonStackView.addArrangedSubview(rentButton)
//        
//        for _ in 0..<5 {
//            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
//            starImageView.tintColor = .systemYellow
//            ratingView.addArrangedSubview(starImageView)
//        }
//        
//        let ratingLabel = UILabel()
//        ratingLabel.text = "4.5 (2.3k reviews)"
//        ratingLabel.font = .systemFont(ofSize: 14)
//        ratingLabel.textColor = .darkGray
//        ratingView.addArrangedSubview(ratingLabel)
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
//            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//            bookImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            bookImageView.widthAnchor.constraint(equalToConstant: 200),
//            bookImageView.heightAnchor.constraint(equalToConstant: 300),
//            
//            ratingView.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 12),
//            ratingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            
//            descriptionLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 20),
//            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            
//            buttonStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
//            buttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
//        ])
//    }
//    
//    private func configureUI() {
//        if let book = book {
//            bookImageView.image = book.coverImageURL
//            descriptionLabel.text = book.description
//            buyButton.setTitle("Buy for $\(String(format: "%.2f", book.price!))", for: .normal)
//            rentButton.setTitle("Rent for $\(String(format: "%.2f", book.price!))", for: .normal)
//        }
//    }
//}
//
//// MARK: - Notification Banner
//class NotificationBanner: UIView {
//    private let containerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor(hex: "#005C78")
//        view.layer.cornerRadius = 12
//        view.clipsToBounds = true
//        return view
//    }()
//    
//    private let messageLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        label.font = .systemFont(ofSize: 16, weight: .medium)
//        return label
//    }()
//    
//    private let dismissButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Dismiss", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
//        return button
//    }()
//    
//    init(message: String) {
//        super.init(frame: .zero)
//        messageLabel.text = message
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        backgroundColor = .clear
//        addSubview(containerView)
//        containerView.addSubview(messageLabel)
//        containerView.addSubview(dismissButton)
//        
//        NSLayoutConstraint.activate([
//            containerView.topAnchor.constraint(equalTo: topAnchor),
//            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            containerView.heightAnchor.constraint(equalToConstant: 50),
//            
//            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            messageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            
//            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
//            dismissButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
//        ])
//        
//        dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
//    }
//    
//    func show(in view: UIView) {
//        self.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(self)
//        
//        NSLayoutConstraint.activate([
//            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//        
//        // Initial state
//        self.alpha = 0
//        self.transform = CGAffineTransform(translationX: 0, y: -50)
//        
//        // Animate in
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
//            self.alpha = 1
//            self.transform = .identity
//        }
//        
//        // Auto dismiss after 3 seconds
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            self?.dismiss()
//        }
//    }
//    
//    @objc private func dismissTapped() {
//        dismiss()
//    }
//    
//    private func dismiss() {
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
//            self.alpha = 0
//            self.transform = CGAffineTransform(translationX: 0, y: -50)
//        } completion: { _ in
//            self.removeFromSuperview()
//        }
//    }
//}
import UIKit


// MARK: - Notification Banner
class NotificationBanner: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#005C78")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            messageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            dismissButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
    }
    
    func show(in view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Initial state
        self.alpha = 0
        self.transform = CGAffineTransform(translationX: 0, y: -50)
        
        // Animate in
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.alpha = 1
            self.transform = .identity
        }
        
        // Auto dismiss after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.dismiss()
        }
    }
    
    @objc private func dismissTapped() {
        dismiss()
    }
    
    private func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.alpha = 0
            self.transform = CGAffineTransform(translationX: 0, y: -50)
        } completion: { _ in
            self.removeFromSuperview()
        }
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


class BookViewController: UIViewController {
    // MARK: - Properties
    var book: Book?
    private var isBookAdded: Bool = false {
        didSet {
            updateAddButtonAppearance()
        }
    }
    
    // MARK: - UI Components
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(hex: "#666666")
        return button
    }()
    
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
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOffset = CGSize(width: 0, height: 4)
        iv.layer.shadowOpacity = 0.3
        iv.layer.shadowRadius = 5
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
    
    private let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buy for $19.99", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor(hex: "#005C78")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return button
    }()
    
    private let rentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Rent for $4.99", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(hex: "#005C78"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(hex: "#005C78").cgColor
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 16
        sv.alignment = .center
        return sv
    }()
    
    // MARK: - Lifecycle Methods
    init(book: Book) {
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
        setupNavigationBar()
        checkIfBookIsAdded()
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        navigationItem.title = book?.title
        let addBarButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = addBarButton
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [bookImageView, ratingView, descriptionLabel, buttonStackView].forEach { contentView.addSubview($0) }
        buttonStackView.addArrangedSubview(buyButton)
        buttonStackView.addArrangedSubview(rentButton)
        
        for _ in 0..<5 {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.tintColor = .systemYellow
            ratingView.addArrangedSubview(starImageView)
        }
        
        let ratingLabel = UILabel()
        ratingLabel.text = "4.5 (2.3k reviews)"
        ratingLabel.font = .systemFont(ofSize: 14)
        ratingLabel.textColor = .darkGray
        ratingView.addArrangedSubview(ratingLabel)
        
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
        if let book = book {
            bookImageView.image = book.coverImageURL
            descriptionLabel.text = book.description
            buyButton.setTitle("Buy for $\(String(format: "%.2f", book.price!))", for: .normal)
            rentButton.setTitle("Rent for $\(String(format: "%.2f", book.price!))", for: .normal)
        }
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
        book.isCollectorsEdition = isCollectorsEdition
        
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
