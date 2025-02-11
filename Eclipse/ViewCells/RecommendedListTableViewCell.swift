//
//  RecommendedListTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 16/11/24.
//

import UIKit

class RecommendedListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listDesc: UILabel!
    @IBOutlet weak var bookCollectionView: UICollectionView!

    var books: [Book] = []
    override func awakeFromNib() {
        super.awakeFromNib()

        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self

        if let layout = bookCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }

    func configure(with recommendedList: RecommendedList) {
        listTitle.text = recommendedList.title
        listDesc.text = recommendedList.subtitle

        books = recommendedList.books.compactMap { bookID in
            mockBooks.first(where: { $0.id == bookID })
        }
        bookCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedBookCell", for: indexPath) as! RecommendedBookCollectionViewCell

        let book = books[indexPath.item]
        cell.bookImage.image = book.coverImageURL

        return cell
    }
}
