import UIKit

class PaymentAndDeliveryViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let deliveryAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivering Address"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.7, alpha: 1.0)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = """
        No.23, James Street,
        New Town, North
        Province
        """
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changeAddressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change", for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(PaymentAndDeliveryViewController.self, action: #selector(changeAddress), for: .touchUpInside)
        return button
    }()
    
    private let addNewAddressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add a New Delivery Address", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(PaymentAndDeliveryViewController.self, action: #selector(addNewAddress), for: .touchUpInside)
        return button
    }()
    
    private let paymentOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment Options"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var upiContainer: UIView = {
        let container = createPaymentOptionContainer(title: "UPI", imageName: "arrow.left.arrow.right")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectUPI))
        container.addGestureRecognizer(tapGesture)
        return container
    }()
    
    private lazy var giftCardContainer: UIView = {
        let container = createPaymentOptionContainer(title: "Redeem Gift Cards", imageName: "gift")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(redeemGiftCard))
        container.addGestureRecognizer(tapGesture)
        return container
    }()
    
    
    
    private let payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pay ₹399", for: .normal)
        button.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.7, alpha: 1.0)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(PaymentAndDeliveryViewController.self, action: #selector(pay), for: .touchUpInside)
        return button
    }()
    
    private let payButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
   
    
    private func createPaymentOptionContainer(title: String, imageName: String) -> UIView {
        let container = UIView()
        container.backgroundColor = .systemGray6
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = .systemGray3
        chevron.contentMode = .scaleAspectFit
        chevron.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(label)
        container.addSubview(imageView)
        container.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 56),
            
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            chevron.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            chevron.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            chevron.widthAnchor.constraint(equalToConstant: 12),
            chevron.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return container
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Johnathan Cahn"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add container view to main view
        view.addSubview(containerView)
        
        // Add scroll view to container
        containerView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Add pay button container to main view
        containerView.addSubview(payButtonContainer)
        payButtonContainer.addSubview(payButton)
        
        // Add content
        contentView.addSubview(deliveryAddressLabel)
        contentView.addSubview(addressContainer)
        addressContainer.addSubview(addressLabel)
        addressContainer.addSubview(changeAddressButton)
        contentView.addSubview(addNewAddressButton)
        contentView.addSubview(paymentOptionsLabel)
        contentView.addSubview(upiContainer)
        contentView.addSubview(giftCardContainer)
        
        NSLayoutConstraint.activate([
            // Container View
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Pay Button Container
            payButtonContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            payButtonContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            payButtonContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            payButtonContainer.heightAnchor.constraint(equalToConstant: 88),
            
            // Pay Button
            payButton.topAnchor.constraint(equalTo: payButtonContainer.topAnchor),
            payButton.leadingAnchor.constraint(equalTo: payButtonContainer.leadingAnchor, constant: 16),
            payButton.trailingAnchor.constraint(equalTo: payButtonContainer.trailingAnchor, constant: -16),
            payButton.heightAnchor.constraint(equalToConstant: 56),
            
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: payButtonContainer.topAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Content Layout
            deliveryAddressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            deliveryAddressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            addressContainer.topAnchor.constraint(equalTo: deliveryAddressLabel.bottomAnchor, constant: 16),
            addressContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addressContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            addressLabel.topAnchor.constraint(equalTo: addressContainer.topAnchor, constant: 16),
            addressLabel.leadingAnchor.constraint(equalTo: addressContainer.leadingAnchor, constant: 16),
            addressLabel.bottomAnchor.constraint(equalTo: addressContainer.bottomAnchor, constant: -16),
            
            changeAddressButton.centerYAnchor.constraint(equalTo: addressContainer.centerYAnchor),
            changeAddressButton.trailingAnchor.constraint(equalTo: addressContainer.trailingAnchor, constant: -16),
            
            addNewAddressButton.topAnchor.constraint(equalTo: addressContainer.bottomAnchor, constant: 16),
            addNewAddressButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addNewAddressButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addNewAddressButton.heightAnchor.constraint(equalToConstant: 56),
            
            paymentOptionsLabel.topAnchor.constraint(equalTo: addNewAddressButton.bottomAnchor, constant: 32),
            paymentOptionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            upiContainer.topAnchor.constraint(equalTo: paymentOptionsLabel.bottomAnchor, constant: 16),
            upiContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            upiContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            giftCardContainer.topAnchor.constraint(equalTo: upiContainer.bottomAnchor, constant: 12),
            giftCardContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            giftCardContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            giftCardContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func changeAddress() {
        print("Change Address tapped")
    }
    
    @objc private func addNewAddress() {
        print("Add New Address tapped")
    }
    
    @objc private func selectUPI() {
        print("UPI selected")
    }
    
    @objc private func redeemGiftCard() {
        print("Redeem Gift Card tapped")
    }
    
    @objc private func pay() {
            let successVC = PaymentSuccessViewController()
            successVC.modalPresentationStyle = .overFullScreen
            present(successVC, animated: false)
        }
}

