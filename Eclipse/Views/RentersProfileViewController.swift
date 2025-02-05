
//
//  VCollectorsEditionViewController.swift
//  Eclipse
//
//  Created by admin48 on 15/11/24.
//

import UIKit

class RentersProfileViewController: UIViewController {
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
        button.layer.cornerRadius = 15
        button.tintColor = UIColor(named: "#005C78") ?? .systemBlue
        return button
    }()

    private let collectorsEditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Collectors Edition"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = UIColor(hex: "B19065")
        return label
    }()
    
    private let collectorsContainer: UIView = {
        let view = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "D4BC86").cgColor,
            UIColor(hex: "B19065").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private let collectorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "John Doe"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
        booksCollectionView.dataSource = self
        booksCollectionView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "< Back",
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

    @objc private func chatButtonTapped() {
        let chatVC = ChatViewController()
        chatVC.title = nameLabel.text
        navigationController?.pushViewController(chatVC, animated: true)
    }

    private func setupUI() {
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
        chatButton.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            chatButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            chatButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            chatButton.widthAnchor.constraint(equalToConstant: 30),
            chatButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        view.addSubview(collectorsContainer)
        collectorsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectorsEditionLabel)
        collectorsEditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        collectorsContainer.addSubview(collectorsStackView)
        collectorsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectorsEditionLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            collectorsEditionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            collectorsContainer.topAnchor.constraint(equalTo: collectorsEditionLabel.bottomAnchor, constant: 16),
            collectorsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectorsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectorsContainer.heightAnchor.constraint(equalToConstant: 200),
            
            collectorsStackView.topAnchor.constraint(equalTo: collectorsContainer.topAnchor, constant: 20),
            collectorsStackView.leadingAnchor.constraint(equalTo: collectorsContainer.leadingAnchor, constant: 20),
            collectorsStackView.trailingAnchor.constraint(equalTo: collectorsContainer.trailingAnchor, constant: -20),
            collectorsStackView.bottomAnchor.constraint(equalTo: collectorsContainer.bottomAnchor, constant: -20)
        ])
        
        for bookID in collectorsEditionBooks {
            let bookImageView = UIImageView()
            let book = getBookByID(bookID)
            bookImageView.image = book?.coverImageURL
            bookImageView.contentMode = .scaleAspectFill
            bookImageView.layer.cornerRadius = 10
            bookImageView.clipsToBounds = true
            bookImageView.backgroundColor = .white
            
            collectorsStackView.addArrangedSubview(bookImageView)
            NSLayoutConstraint.activate([
                bookImageView.widthAnchor.constraint(equalToConstant: 100),
                bookImageView.heightAnchor.constraint(equalToConstant: 150)
            ])
        }

        view.addSubview(booksCollectionView)
        booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            booksCollectionView.topAnchor.constraint(equalTo: collectorsContainer.bottomAnchor, constant: 16),
            booksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            booksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            booksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let gradientLayer = collectorsContainer.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = collectorsContainer.bounds
        }
    }
}

extension RentersProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regularBooks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        
        let bookId = regularBooks[indexPath.item]
        
        if let book = getBookByID(bookId) {
            cell.configure(with: book)
        } else {
            print("Book not found for ID: \(bookId)")
        }
        
        return cell
    }

//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == self.booksCollectionView{
//            let selectedBookId = regularBooks[indexPath.item]
//            if let selectedBook = getBookByID(selectedBookId) {
//                let bookVC = BookViewController(book: selectedBook)
//                navigationController?.pushViewController(bookVC, animated: true)
//            } else {
//                print("Book not found for ID: \(selectedBookId)")
//            }
//        }
//    }
    
}


