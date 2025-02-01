import Foundation

import UIKit

class CartViewController: UIViewController {
    
    private var rentalDays: Int = 4
    
    var bookInCart: BookF!

    private let bookContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()

    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()

    private let durationContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.text = "4 Days"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.tintColor = .systemTeal
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(decreaseDays), for: .touchUpInside)
        return button
    }()

    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.tintColor = .systemTeal
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(increaseDays), for: .touchUpInside)
        return button
    }()

    private let pricePerDayLabel: UILabel = {
        let label = UILabel()
        label.text = "₹40 per day"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private let addressContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()

    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let addressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pickup Address"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "NIBM Road Pune."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()

    private let securityContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()

    private let securityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Security Amount"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showInfoScreen), for: .touchUpInside)
        return button
    }()

    private let securityAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "₹399"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let securityDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "₹299 book price + ₹100 for rent safety\nYou will receive ₹239 on returning the book."
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Proceed to Checkout", for: .normal)
        button.backgroundColor = UIColor(hex: "005C78", alpha: 1.0)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(proceedToCheckout), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        let firstBook: BookF = bookInCart
        bookTitleLabel.text = firstBook.title
        totalPriceLabel.text = "₹\(40 * rentalDays)"
        userImageView.image = UIImage(named: "profile")

        // Load book thumbnail image
        if let thumbnailUrlString = firstBook.imageLinks?.thumbnail, let thumbnailUrl = URL(string: thumbnailUrlString) {
            // Asynchronously download the thumbnail
            let session = URLSession(configuration: .default)
            let downloadTask = session.dataTask(with: thumbnailUrl) { [weak self] data, response, error in
                if let error = error {
                    print("Error loading thumbnail: \(error)")
                    return
                }
                
                // Check and assign the image
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.bookImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.bookImageView.image = UIImage(systemName: "book.fill") // Fallback image
                    }
                }
            }
            downloadTask.resume()
        } else {
            // Use fallback image if URL is invalid
            bookImageView.image = UIImage(systemName: "book.fill")
        }
    }

    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(bookContainer)
        view.addSubview(addressContainer)
        view.addSubview(securityContainer)
        view.addSubview(checkoutButton)

        bookContainer.addSubview(bookImageView)
        bookContainer.addSubview(bookTitleLabel)
        bookContainer.addSubview(durationContainer)
        bookContainer.addSubview(totalPriceLabel)
        bookContainer.addSubview(totalLabel)

        durationContainer.addArrangedSubview(minusButton)
        durationContainer.addArrangedSubview(durationLabel)
        durationContainer.addArrangedSubview(plusButton)
        durationContainer.addArrangedSubview(pricePerDayLabel)
        durationContainer.spacing = 10


        addressContainer.addSubview(userImageView)
        addressContainer.addSubview(userNameLabel)
        addressContainer.addSubview(addressTitleLabel)
        addressContainer.addSubview(addressLabel)

        securityContainer.addSubview(securityTitleLabel)
        securityContainer.addSubview(securityAmountLabel)
        securityContainer.addSubview(securityDetailLabel)
        securityContainer.addSubview(infoButton)
        
        setupConstraints()
    }

    

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            bookContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bookContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            bookImageView.topAnchor.constraint(equalTo: bookContainer.topAnchor, constant: 16),
            bookImageView.leadingAnchor.constraint(equalTo: bookContainer.leadingAnchor, constant: 16),
            bookImageView.widthAnchor.constraint(equalToConstant: 80),
            bookImageView.heightAnchor.constraint(equalToConstant: 120),
            bookImageView.bottomAnchor.constraint(equalTo: bookContainer.bottomAnchor, constant: -16),

            bookTitleLabel.topAnchor.constraint(equalTo: bookImageView.topAnchor),
            bookTitleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 16),
            bookTitleLabel.trailingAnchor.constraint(equalTo: bookContainer.trailingAnchor, constant: -16),

            durationContainer.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: 8),
            durationContainer.leadingAnchor.constraint(equalTo: bookTitleLabel.leadingAnchor),
            durationContainer.trailingAnchor.constraint(lessThanOrEqualTo: bookContainer.trailingAnchor, constant: -32),
            
            minusButton.leadingAnchor.constraint(equalTo: durationContainer.leadingAnchor),

            durationLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 8),
            durationLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -8),

            plusButton.trailingAnchor.constraint(equalTo: durationContainer.trailingAnchor),

            pricePerDayLabel.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: 8),
            pricePerDayLabel.trailingAnchor.constraint(equalTo: bookContainer.trailingAnchor, constant: 16),

            totalPriceLabel.topAnchor.constraint(equalTo: totalLabel.topAnchor),
            totalPriceLabel.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor, constant: 8),
            
            totalLabel.topAnchor.constraint(equalTo: durationContainer.bottomAnchor, constant: 8),
            totalLabel.leadingAnchor.constraint(equalTo: bookTitleLabel.leadingAnchor),

            addressContainer.topAnchor.constraint(equalTo: bookContainer.bottomAnchor, constant: 16),
            addressContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addressContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            userImageView.topAnchor.constraint(equalTo: addressContainer.topAnchor, constant: 16),
            userImageView.leadingAnchor.constraint(equalTo: addressContainer.leadingAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),

            userNameLabel.topAnchor.constraint(equalTo: userImageView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),

            addressTitleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
            addressTitleLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),

            addressLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: 4),
            addressLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: addressContainer.bottomAnchor, constant: -16),
            securityContainer.topAnchor.constraint(equalTo: addressContainer.bottomAnchor, constant: 16),
            securityContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            securityContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            securityTitleLabel.topAnchor.constraint(equalTo: securityContainer.topAnchor, constant: 16),
            securityTitleLabel.leadingAnchor.constraint(equalTo: securityContainer.leadingAnchor, constant: 16),
            
            infoButton.centerYAnchor.constraint(equalTo: securityTitleLabel.centerYAnchor),
            infoButton.leadingAnchor.constraint(equalTo: securityTitleLabel.trailingAnchor, constant: 8),

            securityAmountLabel.topAnchor.constraint(equalTo: securityTitleLabel.bottomAnchor, constant: 8),
            securityAmountLabel.leadingAnchor.constraint(equalTo: securityContainer.leadingAnchor, constant: 16),
            
            securityDetailLabel.topAnchor.constraint(equalTo: securityAmountLabel.bottomAnchor, constant: 8),
            securityDetailLabel.leadingAnchor.constraint(equalTo: securityContainer.leadingAnchor, constant: 16),
            securityDetailLabel.trailingAnchor.constraint(equalTo: securityContainer.trailingAnchor, constant: -16),
            securityDetailLabel.bottomAnchor.constraint(equalTo: securityContainer.bottomAnchor, constant: -16),

            checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50),

            minusButton.widthAnchor.constraint(equalToConstant: 40),
            plusButton.widthAnchor.constraint(equalToConstant: 40),
            durationLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    @objc private func decreaseDays() {
        guard rentalDays > 1 else { return }
        rentalDays -= 1
        durationLabel.text = "\(rentalDays) Days"
        updateTotalPrice(with: rentalDays)
    }

    @objc private func increaseDays() {
        rentalDays += 1
        durationLabel.text = "\(rentalDays) Days"
        updateTotalPrice(with: rentalDays)
    }

    private func updateTotalPrice(with days: Int) {
        let totalPrice = 40 * days
        totalPriceLabel.text = "₹\(totalPrice)"
    }

    @objc private func showInfoScreen() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .pageSheet
        present(infoVC, animated: true, completion: nil)
    }
    
    @objc private func proceedToCheckout() {
        let paymentVC = PaymentAndDeliveryViewController()
        paymentVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(paymentVC, animated: true)
    }

    
    class InfoViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
     
            let titleLabel = UILabel()
            titleLabel.text = "Renting Terms & Conditions"
            titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
            titleLabel.textAlignment = .center
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let termsLabel = UILabel()
            termsLabel.text = """
            Security: To rent this book, you’ll need to pay a refundable amount equal to the price of the book. This ensures the safe return of the book.

            Rent Fee: In addition, you’ll be charged a rental fee for the duration of the rental.

            Refund: Once you return the book in good condition, you’ll receive the security amount back, minus the ₹100 rent fee.
            """
            termsLabel.font = .systemFont(ofSize: 16)
            termsLabel.numberOfLines = 0
            termsLabel.textAlignment = .left
            termsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            let contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            contentView.addSubview(titleLabel)

            contentView.addSubview(termsLabel)

            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
            
            NSLayoutConstraint.activate([

                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)

            ])
            
            NSLayoutConstraint.activate([
                termsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                termsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                termsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                termsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
            
            if let sheetPresentationController = sheetPresentationController {
                sheetPresentationController.detents = [.custom { _ in return 400 }]
                sheetPresentationController.prefersGrabberVisible = true
            }
        }
    }

}
