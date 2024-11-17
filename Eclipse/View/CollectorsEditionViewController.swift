//
//  VCollectorsEditionViewController.swift
//  Eclipse
//
//  Created by admin48 on 15/11/24.
//


import UIKit

class BooksViewController: UIViewController {
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
        label.text = "John Doe"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "5 KM"
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
        button.layer.cornerRadius = 15  // Half of the height
        
        button.tintColor = UIColor(named: "#005C78") ?? .systemBlue
        return button
    }()

    private let collectorsEditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Collectors Edition"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private let collectorsEditionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private let collectorsEditionContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()

    private let booksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 160)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: "BookCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()

    // Sample data
    private let collectorsEditionBooks = ["book1", "it_ends_with_us", "malory_towers", "verity"]
    private let regularBooks = ["pride_and_prejudice", "devotion", "catcher_in_the_rye", "where_the_crawdads_sing", "dune", "great_gatsby"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        booksCollectionView.dataSource = self
        booksCollectionView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        setupUI()
    }

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

    // Add new chat button action
    @objc private func chatButtonTapped() {
        let chatVC = ChatViewController()
        // Pass the name from nameLabel to the chat
        chatVC.title = nameLabel.text
        navigationController?.pushViewController(chatVC, animated: true)
    }

    // MARK: - Setup UI
    private func setupUI() {
        // Profile Section
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100)
        ])

        headerView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60)
        ])

        headerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12)
        ])

        headerView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
        ])

        // Add rating button and setup its action
        headerView.addSubview(ratingButton)
        ratingButton.translatesAutoresizingMaskIntoConstraints = false
        ratingButton.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            ratingButton.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor, constant: 16),
            ratingButton.centerYAnchor.constraint(equalTo: distanceLabel.centerYAnchor)
        ])

        headerView.addSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: ratingButton.trailingAnchor, constant: 4),
            starImageView.centerYAnchor.constraint(equalTo: ratingButton.centerYAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16)
        ])

        headerView.addSubview(chatButton)
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        // Add target for chat button
        chatButton.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            chatButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            chatButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            chatButton.widthAnchor.constraint(equalToConstant: 30),
            chatButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        let collectorsBackground = UIView()
        collectorsBackground.backgroundColor = UIColor(hex: "C1A875")
        view.addSubview(collectorsBackground)
        collectorsBackground.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectorsEditionLabel)
        collectorsEditionLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectorsEditionScrollView)
        collectorsEditionScrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectorsBackground.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            collectorsBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectorsBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectorsEditionLabel.topAnchor.constraint(equalTo: collectorsBackground.topAnchor, constant: 16),
            collectorsEditionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            collectorsEditionScrollView.topAnchor.constraint(equalTo: collectorsEditionLabel.bottomAnchor, constant: 8),
            collectorsEditionScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectorsEditionScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectorsEditionScrollView.heightAnchor.constraint(equalToConstant: 150),
            collectorsEditionScrollView.bottomAnchor.constraint(equalTo: collectorsBackground.bottomAnchor, constant: -16)
        ])

        collectorsEditionScrollView.addSubview(collectorsEditionContainer)
        collectorsEditionContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectorsEditionContainer.topAnchor.constraint(equalTo: collectorsEditionScrollView.topAnchor),
            collectorsEditionContainer.leadingAnchor.constraint(equalTo: collectorsEditionScrollView.leadingAnchor, constant: 16),
            collectorsEditionContainer.trailingAnchor.constraint(equalTo: collectorsEditionScrollView.trailingAnchor),
            collectorsEditionContainer.bottomAnchor.constraint(equalTo: collectorsEditionScrollView.bottomAnchor)
        ])

        for bookImageName in collectorsEditionBooks {
            let bookImageView = UIImageView()
            bookImageView.image = UIImage(named: bookImageName)
            bookImageView.contentMode = .scaleAspectFit
            bookImageView.layer.cornerRadius = 8
            bookImageView.clipsToBounds = true
            bookImageView.backgroundColor = .white
            
            collectorsEditionContainer.addArrangedSubview(bookImageView)
            bookImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            bookImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        }

        // Regular Books Grid
        view.addSubview(booksCollectionView)
        booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            booksCollectionView.topAnchor.constraint(equalTo: collectorsBackground.bottomAnchor, constant: 16),
            booksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            booksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            booksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension BooksViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regularBooks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.configure(with: regularBooks[indexPath.item])
        return cell
    }
}
