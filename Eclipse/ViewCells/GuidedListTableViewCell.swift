//
//  GuidedListTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 18/11/24.
//

import UIKit

class GuidedListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var guidedList: GuidedList?
    var bookSelectionDelegate: GuidedListViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.numberOfLines = 0
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with guidedList: GuidedList) {
        self.guidedList = guidedList
        title.text = guidedList.title
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guidedList?.books.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guidedListCollectionCell", for: indexPath) as! GuidedListCollectionViewCell
        
        if let bookID = guidedList?.books[indexPath.item], let book = getBookByID(bookID) {
            cell.bookImage.image = book.coverImageURL
        }
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let bookID = guidedList?.books[indexPath.item], let book = getBookByID(bookID) {
            bookSelectionDelegate?.didSelectBook(book)
        }
    }
    
    // Helper method to get book by ID
    func getBookByID(_ id: String) -> Book? {
        return mockBooks.first { $0.id == id }
    }
}
