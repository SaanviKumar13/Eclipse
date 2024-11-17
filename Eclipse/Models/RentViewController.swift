//
//  RentViewController.swift
//  Eclipse
//
//  Created by admin48 on 09/11/24.
//

import UIKit

////class HomeViewController: UIViewController {
////    
////    private let scrollView: UIScrollView = {
////        let scroll = UIScrollView()
////        scroll.translatesAutoresizingMaskIntoConstraints = false
////        scroll.showsVerticalScrollIndicator = false
////        return scroll
////    }()
////    
////    private let contentView: UIView = {
////        let view = UIView()
////        view.translatesAutoresizingMaskIntoConstraints = false
////        return view
////    }()
////    
////    private let searchContainer: UIView = {
////        let view = UIView()
////        view.translatesAutoresizingMaskIntoConstraints = false
////        view.backgroundColor = .systemGray6
////        view.layer.cornerRadius = 10
////        return view
////    }()
////    
////    private let searchBar: UISearchBar = {
////        let search = UISearchBar()
////        search.translatesAutoresizingMaskIntoConstraints = false
////        search.placeholder = "Search"
////        search.backgroundImage = UIImage()
////        search.searchTextField.backgroundColor = .clear
////        return search
////    }()
////    
////    private let profileButton: UIButton = {
////        let button = UIButton()
////        button.translatesAutoresizingMaskIntoConstraints = false
////        button.setImage(UIImage(named: "profile"), for: .normal)
////        button.layer.cornerRadius = 20
////        button.clipsToBounds = true
////        return button
////    }()
////    
////    private let titleLabel: UILabel = {
////        let label = UILabel()
////        label.translatesAutoresizingMaskIntoConstraints = false
////        label.text = "Rent from your\nCommunity"
////        label.numberOfLines = 2
////        label.font = .systemFont(ofSize: 30, weight: .bold)
////        return label
////    }()
////    
////    private let currentlyRentedLabel: UILabel = {
////        let label = UILabel()
////        label.translatesAutoresizingMaskIntoConstraints = false
////        label.text = "Currently Rented"
////        label.font = .systemFont(ofSize: 20, weight: .regular)
////        return label
////    }()
////    
////    private let seeMoreButton: UIButton = {
////        let button = UIButton()
////        button.translatesAutoresizingMaskIntoConstraints = false
////        button.setTitle("See more", for: .normal)
////        button.setTitleColor(.systemBlue, for: .normal)
////        return button
////    }()
////    
////    private let currentlyRentedCollectionView: UICollectionView = {
////        let layout = UICollectionViewFlowLayout()
////        layout.scrollDirection = .horizontal
////        layout.minimumInteritemSpacing = 15
////        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
////        cv.translatesAutoresizingMaskIntoConstraints = false
////        cv.showsHorizontalScrollIndicator = false
////        cv.backgroundColor = .clear
////        return cv
////    }()
////    
////    private let rentersLabel: UILabel = {
////        let label = UILabel()
////        label.translatesAutoresizingMaskIntoConstraints = false
////        label.text = "Top Renters in your Area"
////        label.font = .systemFont(ofSize: 25, weight: .medium)
////        return label
////    }()
////    
////    private let rentersCollectionView: UICollectionView = {
////        let layout = UICollectionViewFlowLayout()
////        layout.scrollDirection = .horizontal
////        layout.minimumInteritemSpacing = 15
////        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
////        cv.translatesAutoresizingMaskIntoConstraints = false
////        cv.showsHorizontalScrollIndicator = false
////        cv.backgroundColor = .clear
////        return cv
////    }()
////    
////    private let suggestedBooksLabel: UILabel = {
////        let label = UILabel()
////        label.translatesAutoresizingMaskIntoConstraints = false
////        label.text = "Books you might like to rent"
////        label.font = .systemFont(ofSize: 25, weight: .medium)
////        return label
////    }()
////    
////    private let suggestedBooksCollectionView: UICollectionView = {
////        let layout = UICollectionViewFlowLayout()
////        layout.scrollDirection = .horizontal
////        layout.minimumInteritemSpacing = 15
////        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
////        cv.translatesAutoresizingMaskIntoConstraints = false
////        cv.showsHorizontalScrollIndicator = false
////        cv.backgroundColor = .clear
////        return cv
////    }()
////    
////    private let currentlyRentedBooks = ["gone_girl", "verity"]
////    private let renterProfiles = ["profile", "profile1", "profile2", "profile3", "profile4"]
////    private let renterNames = ["Sara\nMukhija", "Dhruv\nSharma", "Ananya\nSharma", "Raj\nVerma"]
////    private let suggestedBooks = ["dune", "malory_towers", "devotion", "book1", "flawed"]
////    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        setupUI()
////        setupCollectionViews()
////    }
////    
////    private func setupUI() {
////        view.backgroundColor = .white
////        
////        view.addSubview(scrollView)
////        scrollView.addSubview(contentView)
////        
////        [searchContainer, profileButton, titleLabel, currentlyRentedLabel,
////         seeMoreButton, currentlyRentedCollectionView, rentersLabel,
////         rentersCollectionView, suggestedBooksLabel, suggestedBooksCollectionView].forEach {
////            contentView.addSubview($0)
////        }
////        
////        searchContainer.addSubview(searchBar)
////        
////        seeMoreButton.addTarget(self, action: #selector(seeMoreTapped), for: .touchUpInside)
////        
////        setupConstraints()
////    }
////    
////    private func setupConstraints() {
////        NSLayoutConstraint.activate([
////            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
////            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
////            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
////            
////            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
////            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
////            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
////            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
////            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
////            
////            searchContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
////            searchContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            searchContainer.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -10),
////            searchContainer.heightAnchor.constraint(equalToConstant: 50),
////            
////            searchBar.topAnchor.constraint(equalTo: searchContainer.topAnchor),
////            searchBar.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor),
////            searchBar.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor),
////            searchBar.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor),
////            
////            profileButton.topAnchor.constraint(equalTo: searchContainer.topAnchor),
////            profileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
////            profileButton.widthAnchor.constraint(equalToConstant: 40),
////            profileButton.heightAnchor.constraint(equalToConstant: 40),
////            
////            titleLabel.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 30),
////            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
////            
////            currentlyRentedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
////            currentlyRentedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            
////            seeMoreButton.centerYAnchor.constraint(equalTo: currentlyRentedLabel.centerYAnchor),
////            seeMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
////            
////            currentlyRentedCollectionView.topAnchor.constraint(equalTo: currentlyRentedLabel.bottomAnchor, constant: 20),
////            currentlyRentedCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            currentlyRentedCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
////            currentlyRentedCollectionView.heightAnchor.constraint(equalToConstant: 200),
////            
////            rentersLabel.topAnchor.constraint(equalTo: currentlyRentedCollectionView.bottomAnchor, constant: 30),
////            rentersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            
////            rentersCollectionView.topAnchor.constraint(equalTo: rentersLabel.bottomAnchor, constant: 20),
////            rentersCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            rentersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
////            rentersCollectionView.heightAnchor.constraint(equalToConstant: 120),
////            
////            suggestedBooksLabel.topAnchor.constraint(equalTo: rentersCollectionView.bottomAnchor, constant: 30),
////            suggestedBooksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            
////            suggestedBooksCollectionView.topAnchor.constraint(equalTo: suggestedBooksLabel.bottomAnchor, constant: 20),
////            suggestedBooksCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            suggestedBooksCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
////            suggestedBooksCollectionView.heightAnchor.constraint(equalToConstant: 200),
////            suggestedBooksCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
////        ])
////    }
////    
////    private func setupCollectionViews() {
////        currentlyRentedCollectionView.delegate = self
////        currentlyRentedCollectionView.dataSource = self
////        rentersCollectionView.delegate = self
////        rentersCollectionView.dataSource = self
////        suggestedBooksCollectionView.delegate = self
////        suggestedBooksCollectionView.dataSource = self
////        
////        currentlyRentedCollectionView.register(BookCell.self, forCellWithReuseIdentifier: "BookCell")
////        rentersCollectionView.register(RenterCell.self, forCellWithReuseIdentifier: "RenterCell")
////        suggestedBooksCollectionView.register(BookCell.self, forCellWithReuseIdentifier: "BookCell")
////    }
////    
////    @objc private func seeMoreTapped() {
////        let bookManagementVC = BookManagementViewController()
////        navigationController?.pushViewController(bookManagementVC, animated: true)
////    }
////}
////
////extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        switch collectionView {
////        case currentlyRentedCollectionView:
////            return currentlyRentedBooks.count
////        case rentersCollectionView:
////            return renterProfiles.count
////        case suggestedBooksCollectionView:
////            return suggestedBooks.count
////        default:
////            return 0
////        }
////    }
////    
////  
////    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////         switch collectionView {
////         case currentlyRentedCollectionView:
////             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCell", for: indexPath) as! BookCell
////             cell.configure(with: currentlyRentedBooks[indexPath.item])
////             return cell
////             
////         case rentersCollectionView:
////             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RenterCell", for: indexPath) as! RenterCell
////             cell.configure(with: rentersProfiles[indexPath.item])
////             return cell
////             
////         case suggestedBooksCollectionView:
////             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
////             cell.configure(with: suggestedBooks[indexPath.item])
////             return cell
////             
////         default:
////             return UICollectionViewCell()
////         }
////     }
//// }
//
//
//
//
//class RentViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Create a label
//        let label = UILabel()
//        label.text = "Hello, World!"
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
//
//        // Create a button
//        let button = UIButton(type: .system)
//        button.setTitle("Tap Me", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        // Add the label and button to the view
//        view.addSubview(label)
//        view.addSubview(button)
//
//        // Set up constraints using NSLayoutConstraint
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
//        ])
//    }
//
//    @objc func buttonTapped() {
//        // Handle button tap
//        print("Button tapped!")
//    }
//}
