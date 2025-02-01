import UIKit

protocol NearbyRentersCellDelegate: AnyObject {
    func requestRentTapped(for cell: CustomCell)
}

class CustomCell: UITableViewCell {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let locationIcon = UIImageView()
    private let distanceLabel = UILabel()
    private let priceLabel = UILabel()
    private let requestButton = UIButton()
    
    weak var delegate: NearbyRentersCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        locationIcon.image = UIImage(systemName: "location.fill")
        locationIcon.tintColor = .systemGray
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.contentMode = .scaleAspectFit
        
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = .systemFont(ofSize: 15)
        distanceLabel.textColor = .systemGray
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .systemFont(ofSize: 17, weight: .medium)
        priceLabel.textColor = UIColor(hex: "A40000")
        
        requestButton.setTitle("Request Rent", for: .normal)
        requestButton.setTitleColor(UIColor(hex: "005C78"), for: .normal)
        requestButton.titleLabel?.font = .systemFont(ofSize: 17)
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        requestButton.addTarget(self, action: #selector(requestRentTapped), for: .touchUpInside)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationIcon)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(requestButton)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 2),
            
            locationIcon.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            locationIcon.widthAnchor.constraint(equalToConstant: 15),
            locationIcon.heightAnchor.constraint(equalToConstant: 15),
            
            distanceLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 5),
            distanceLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            requestButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            requestButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
        ])
    }
    
    @objc private func requestRentTapped() {
        delegate?.requestRentTapped(for: self)
    }
    
    func configure(name: String, distance: Double, price: Double, profileImage: UIImage) {
        profileImageView.image = profileImage
        nameLabel.text = name
        distanceLabel.text = "\(distance)Km"
        priceLabel.text = "₹\(Int(price)) per day"
    }
}

class RentersNearbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()
    private let titleLabel = UILabel()

    var selectedBook: BookF?
    var actionType: String?

    private let renters = [
        ("John Doe", 2.0, 40, UIImage(named: "profile")!),
        ("Jane Riviera", 2.5, 50, UIImage(named: "profile")!),
        ("Roderick Usher", 3.0, 35, UIImage(named: "profile")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureActionType()
    }

    private func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "chevron.left")
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
    }


    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.separatorColor = .systemGray5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureActionType() {
        if let actionType = actionType {
            navigationItem.title = actionType == "Buy" ? "Buyers Near You" : "Renters Near You"
        } else {
            navigationItem.title = "Nearby Users"
        }
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return renters.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }

        let renter = renters[indexPath.row]
        cell.configure(name: renter.0, distance: renter.1, price: Double(renter.2), profileImage: renter.3)
        cell.delegate = self
        return cell
    }
}

extension RentersNearbyViewController: NearbyRentersCellDelegate {
    func requestRentTapped(for cell: CustomCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        let renter = renters[indexPath.row]

        let cartVC = CartViewController()
        cartVC.bookInCart = selectedBook
        navigationController?.pushViewController(cartVC, animated: true)
    }
}

