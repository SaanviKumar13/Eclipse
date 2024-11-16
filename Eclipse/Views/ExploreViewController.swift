//
//  ExploreViewController.swift
//  Eclipse
//
//  Created by user@87 on 15/11/24.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var quizText: UILabel!
    @IBOutlet weak var quizView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bookMiddle: UIImageView!
    @IBOutlet weak var bookLeft: UIImageView!
    @IBOutlet weak var bookRight: UIImageView!
    @IBOutlet weak var authorCollectionView: UICollectionView!
    @IBOutlet weak var recommendedListTableView: UITableView!

    var selectedCategoryIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        quizText.numberOfLines = 0
        quizText.lineBreakMode = .byWordWrapping

        collectionView.dataSource = self
        collectionView.delegate = self
        authorCollectionView.dataSource = self
        authorCollectionView.delegate = self
        recommendedListTableView.dataSource = self
        recommendedListTableView.delegate = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

        if let layout = authorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

        setBooksView()
        addGradientToView()
    }

    func setBooksView() {
        bookMiddle.layer.cornerRadius = 30
        bookMiddle.clipsToBounds = true
        bookLeft.layer.cornerRadius = 30
        bookLeft.clipsToBounds = true
        bookRight.layer.cornerRadius = 30
        bookRight.clipsToBounds = true

        bookLeft.alpha = 0.7
        bookRight.alpha = 0.7
        bookLeft.transform = CGAffineTransform(rotationAngle: -0.2)
        bookRight.transform = CGAffineTransform(rotationAngle: 0.2)
    }

    func addGradientToView() {
        quizView.layer.cornerRadius = 10
        quizView.clipsToBounds = true

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = quizView.bounds
        gradientLayer.colors = [
            UIColor(red: 0.0, green: 0.36, blue: 0.47, alpha: 1.0).cgColor,
            UIColor(red: 0.0, green: 0.36, blue: 0.47, alpha: 0.6).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        quizView.layer.insertSublayer(gradientLayer, at: 0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendedLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recommendedListCell", for: indexPath) as! RecommendedListTableViewCell

        let recommendedList = recommendedLists[indexPath.row]
        cell.listTitle.text = recommendedList.title
        cell.listDesc.text = recommendedList.subtitle

        cell.bookCollectionView.dataSource = self
        cell.bookCollectionView.delegate = self
        cell.bookCollectionView.tag = indexPath.row
        cell.bookCollectionView.reloadData()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return categories.count
        } else if collectionView == self.authorCollectionView {
            return authors.count
        } else if let recommendedList = recommendedLists[safe: collectionView.tag] {
            return recommendedList.books.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = categories[indexPath.item]
            cell.configure(for: category, isSelected: indexPath.item == selectedCategoryIndex)
            return cell
        } else if collectionView == self.authorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "authorCell", for: indexPath) as! AuthorCollectionViewCell
            let author = authors[indexPath.item]
            cell.configure(for: author)
            return cell
        } else if let recommendedList = recommendedLists[safe: collectionView.tag] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedBookCell", for: indexPath) as! RecommendedBookCollectionViewCell
            let bookID = recommendedList.books[indexPath.item]
            if let book = mockBooks.first(where: { $0.id == bookID }) {
                cell.bookImage.image = book.coverImageURL
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.authorCollectionView {
            let selectedAuthor = authors[indexPath.item]
            performSegue(withIdentifier: "showAuthorProfileSegue", sender: selectedAuthor)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAuthorProfileSegue" {
            if let authorProfileVC = segue.destination as? AuthorProfileViewController,
               let selectedAuthor = sender as? Author {
                authorProfileVC.author = selectedAuthor
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.authorCollectionView {
            return CGSize(width: 100, height: collectionView.bounds.height)
        }
        return CGSize(width: 126, height: 189)
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
