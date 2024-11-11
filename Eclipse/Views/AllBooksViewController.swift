//
//  AllBooksViewController.swift
//  Eclipse
//
//  Created by user@87 on 11/11/24.
//

import UIKit

class AllBooksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var booksCollectionView: UICollectionView!

    let categories = ["All", "Fiction", "Romance", "Dystopian", "Classic", "Mystery"]
    var selectedCategoryIndex: Int = 0
    var displayedBooks: [Book] = []
    
    func displayBooksForSelectedCategory() {
        if selectedCategoryIndex == 0 {
            displayedBooks = mockBooks
        } else {
            let selectedCategory = categories[selectedCategoryIndex]
            displayedBooks = mockBooks.filter { $0.genre == selectedCategory }
        }
        booksCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.collectionView ? categories.count : displayedBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = categories[indexPath.item]
            cell.configure(for: category, isSelected: indexPath.item == selectedCategoryIndex)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCollectionViewCell
            let book = displayedBooks[indexPath.item]
            cell.configure(with: book)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            selectedCategoryIndex = indexPath.item
            collectionView.reloadData()
            displayBooksForSelectedCategory()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let category = categories[indexPath.item]
            let padding: CGFloat = 48
            let textWidth = (category as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width
            return CGSize(width: textWidth + padding, height: 50)
        } else {
            let width = (collectionView.frame.width - 30) / 2
            return CGSize(width: width, height: 250)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.backgroundColor = .clear
        
        let bookLayout = UICollectionViewFlowLayout()
        bookLayout.scrollDirection = .vertical
        booksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: bookLayout)
        booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        booksCollectionView.dataSource = self
        booksCollectionView.delegate = self
        booksCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCell")
        booksCollectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        view.addSubview(booksCollectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            
            booksCollectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            booksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            booksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            booksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        displayBooksForSelectedCategory()
    }
}
