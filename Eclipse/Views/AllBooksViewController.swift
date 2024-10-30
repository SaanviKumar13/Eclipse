//
//  AllBooksViewController.swift
//  Eclipse
//
//  Created by user@87 on 30/10/24.
//

import UIKit

class AllBooksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var booksCollectionView: UICollectionView!

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
            let width = (collectionView.frame.width - 40) / 2
            return CGSize(width: width, height: 250)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        booksCollectionView.dataSource = self
        booksCollectionView.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        displayBooksForSelectedCategory()
    }
}

