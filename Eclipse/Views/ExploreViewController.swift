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
    @IBOutlet weak var swipeBook: UIImageView!

    var selectedCategoryIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionView()
        setupTableView()
        setBooksView()
        addGradientToQuizView()
    }

    // MARK: - Setup Methods

    private func setupUI() {
        quizText.numberOfLines = 0
        quizText.lineBreakMode = .byWordWrapping

        swipeBook.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(swipeBookTapped))
        swipeBook.addGestureRecognizer(tapGesture)
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        authorCollectionView.dataSource = self
        authorCollectionView.delegate = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

        if let layout = authorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }

    private func setupTableView() {
        recommendedListTableView.dataSource = self
        recommendedListTableView.delegate = self
    }

    private func setBooksView() {
        [bookMiddle, bookLeft, bookRight].forEach {
            $0?.layer.cornerRadius = 30
            $0?.clipsToBounds = true
        }

        bookLeft.alpha = 0.7
        bookRight.alpha = 0.7
        bookLeft.transform = CGAffineTransform(rotationAngle: -0.2)
        bookRight.transform = CGAffineTransform(rotationAngle: 0.2)
    }

    private func addGradientToQuizView() {
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

    // MARK: - Actions

    @objc private func swipeBookTapped() {
        let swipeVC = SwipeScreen()
        swipeVC.modalPresentationStyle = .fullScreen
        present(swipeVC, animated: true, completion: nil)
    }

    // MARK: - TableView DataSource and Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendedLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recommendedListCell", for: indexPath) as? RecommendedListTableViewCell else {
            return UITableViewCell()
        }

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

    // MARK: - CollectionView DataSource and Delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionView:
            return categories.count
        case authorCollectionView:
            return authors.count
        default:
            return recommendedLists[safe: collectionView.tag]?.books.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = categories[indexPath.item]
            cell.configure(for: category, isSelected: indexPath.item == selectedCategoryIndex)
            return cell
        } else if collectionView == authorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "authorCell", for: indexPath) as! AuthorCollectionViewCell
            let author = authors[indexPath.item]
            cell.configure(for: author)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedBookCell", for: indexPath) as! RecommendedBookCollectionViewCell
            if let bookID = recommendedLists[safe: collectionView.tag]?.books[indexPath.item],
               let book = mockBooks.first(where: { $0.id == bookID }) {
                cell.bookImage.image = book.coverImageURL
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case authorCollectionView:
            let selectedAuthor = authors[indexPath.item]
            performSegue(withIdentifier: "showAuthorProfileSegue", sender: selectedAuthor)
        case self.collectionView:
            let selectedCategory = categories[indexPath.item]
            let bookListVC = BookListViewController()
            bookListVC.selectedGenre = selectedCategory
            bookListVC.title = selectedCategory
            navigationController?.pushViewController(bookListVC, animated: true)
        default:
            if let bookID = recommendedLists[safe: collectionView.tag]?.books[indexPath.item],
               let selectedBook = mockBooks.first(where: { $0.id == bookID }) {
//                let bookVC = BookViewController(book: selectedBook)
//                navigationController?.pushViewController(bookVC, animated: true)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAuthorProfileSegue",
           let authorProfileVC = segue.destination as? AuthorProfileViewController,
           let selectedAuthor = sender as? Author {
            authorProfileVC.author = selectedAuthor
        }
    }

    // MARK: - CollectionView Layout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == authorCollectionView {
            return CGSize(width: 100, height: collectionView.bounds.height)
        }
        return CGSize(width: 150, height: 200)
    }
}

// MARK: - Array Safe Subscript Extension

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

