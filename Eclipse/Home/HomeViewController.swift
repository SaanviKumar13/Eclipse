import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var selectedCategoryIndex: Int = 0
    var recommendedLists: [RecommendedList] = []
    var booksByList: [String: [BookF]] = [:]

    let categories = ["Fiction", "Non-Fiction", "Mystery", "Sci-Fi", "Romance"]

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10 // Reduced spacing
        layout.minimumInteritemSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true // Enables paging
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        return cv
    }()

    let recommendedListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10 // Reduced spacing
        layout.minimumInteritemSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(RecommendedListCollectionViewCell.self, forCellWithReuseIdentifier: "recommendedListCell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        setupUI()
        loadRecommendedLists()
    }

    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(recommendedListCollectionView)

        collectionView.dataSource = self
        collectionView.delegate = self

        recommendedListCollectionView.dataSource = self
        recommendedListCollectionView.delegate = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 50),

            recommendedListCollectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            recommendedListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            recommendedListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            recommendedListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadRecommendedLists() {
        fetchRecommendedLists { [weak self] fetchedLists, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching recommended lists: \(error.localizedDescription)")
                return
            }
            if let fetchedLists = fetchedLists {
                self.recommendedLists = fetchedLists
                self.fetchBooksForLists()
            }
        }
    }
    
    private func fetchBooksForLists() {
        let dispatchGroup = DispatchGroup()
        var fetchedBooksByList: [String: [BookF]] = [:]

        for list in recommendedLists {
            dispatchGroup.enter()
            
            let bookIDs = list.books
            
            fetchBooksByIDs(bookIDs: bookIDs) { result in
                defer { dispatchGroup.leave() } // Ensures leave is always called

                switch result {
                case .success(let books):
                    DispatchQueue.main.async {
                        fetchedBooksByList[list.title] = books
                    }
                case .failure(let error):
                    print("❌ Failed to fetch books for list \(list.title): \(error.localizedDescription)")
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.booksByList = fetchedBooksByList // Update UI data
            self.recommendedListCollectionView.reloadData()
        }
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.collectionView ? categories.count : recommendedLists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = categories[indexPath.item]
            cell.configure(for: category, isSelected: indexPath.item == selectedCategoryIndex)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedListCell", for: indexPath) as! RecommendedListCollectionViewCell
            let recommendedList = recommendedLists[indexPath.item]
            let books = booksByList[recommendedList.title] ?? []
            cell.configure(with: recommendedList, books: books)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == self.collectionView ? CGSize(width: 100, height: 40) : CGSize(width: collectionView.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            selectedCategoryIndex = indexPath.item
            collectionView.reloadData()
            let selectedCategory = categories[indexPath.item]
            let bookListVC = BookListViewController()
            bookListVC.selectedGenre = selectedCategory
            bookListVC.title = selectedCategory
            navigationController?.pushViewController(bookListVC, animated: true)
        }
    }
}

