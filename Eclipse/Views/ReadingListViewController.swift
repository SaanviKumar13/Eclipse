import UIKit
import FirebaseFirestore
import FirebaseAuth

class ReadingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var statusLists: [StatusList] = []
    private var customLists: [List] = []
    private var bookImageCache: [String: UIImage] = [:] // Caching book images
    
    private var statusListsListener: ListenerRegistration?
    private var customListsListener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupFirestoreListeners()
        setupCreateCollectionButton()
    }
    
    private func setupFirestoreListeners() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userRef = Firestore.firestore().collection("users").document(userID)
        
        let statusCategories = ["Currently Reading", "Want to Read", "Finished", "Did Not Finish"]
        statusListsListener = userRef.collection("lists").addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching status lists: \(error.localizedDescription)")
                return
            }
            
            self.statusLists = statusCategories.map { category in
                if let doc = snapshot?.documents.first(where: { $0.documentID == category }) {
                    return StatusList.from(document: doc, category: category) ?? StatusList(category: category, bookIDs: [])
                } else {
                    return StatusList(category: category, bookIDs: [])
                }
            }
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        
        customListsListener = userRef.collection("customLists")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }

                if let error = error {
                    print("Error fetching custom lists: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No documents found in customLists")
                    return
                }

                print("Fetched \(documents.count) custom lists")
                documents.forEach { doc in print(doc.data()) }

                self.customLists = documents.compactMap { List.from(document: $0) }
                print("Parsed custom lists: \(self.customLists)")

                DispatchQueue.main.async { self.tableView.reloadData() }
            }
    }
    
    private func setupCreateCollectionButton() {
        let createButton = UIBarButtonItem(title: "Create Collection", style: .plain, target: self, action: #selector(createNewCollectionTapped))
        navigationItem.rightBarButtonItem = createButton
    }
    
    @objc private func createNewCollectionTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let createVC = storyboard.instantiateViewController(withIdentifier: "CreateCollectionViewController") as? CreateCollectionViewController {
            let navController = UINavigationController(rootViewController: createVC)
            navController.modalPresentationStyle = .formSheet
            present(navController, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 2 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? statusLists.count : customLists.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Status Lists" : "Collections"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingListCell", for: indexPath) as? ReadingListTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            configure(cell, with: statusLists[indexPath.row])
        } else {
            configure(cell, with: customLists[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let statusList = statusLists[indexPath.row]
            performSegue(withIdentifier: "showStatusList", sender: statusList)
        } else {
            let selectedList = customLists[indexPath.row]
            performSegue(withIdentifier: "showCustomList", sender: selectedList)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStatusList", let destinationVC = segue.destination as? StatusListViewController, let statusList = sender as? StatusList {
            destinationVC.statusList = statusList
        } else if segue.identifier == "showCustomList", let destinationVC = segue.destination as? CustomListViewController, let selectedList = sender as? List {
            destinationVC.customList = selectedList  // Pass the custom list data to the next view controller
        }
    }

    private func configure(_ cell: ReadingListTableViewCell, with list: StatusList) {
        cell.titleLabel.text = list.category
        cell.subtitleLabel.text = "\(list.bookIDs.count) books"
        loadBookImages(for: cell, with: list.bookIDs)
    }
    
    private func configure(_ cell: ReadingListTableViewCell, with list: List) {
        cell.titleLabel.text = list.title
        cell.subtitleLabel.text = "\(list.bookIDs.count) books"
        cell.privacyIndicator.image = list.isPrivate ? UIImage(systemName: "lock.fill") : UIImage(systemName: "network")
        loadBookImages(for: cell, with: list.bookIDs)
    }
    
    private func loadBookImages(for cell: ReadingListTableViewCell, with bookIDs: [String]) {
        let imageViews = [cell.book1, cell.book2, cell.book3]
        
        if bookIDs.isEmpty {
            for imageView in imageViews { imageView?.image = UIImage(named: "grey_bg") }
            return
        }
        
        for (index, bookID) in bookIDs.prefix(3).enumerated() {
            if let cachedImage = bookImageCache[bookID] {
                imageViews[index]?.image = cachedImage
            } else {
                fetchGoogleBook(volumeId: bookID) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let book):
                            if let imageUrl = book?.imageLinks?.thumbnail, let url = URL(string: imageUrl) {
                                URLSession.shared.dataTask(with: url) { data, _, _ in
                                    if let data = data, let image = UIImage(data: data) {
                                        self.bookImageCache[bookID] = image
                                        DispatchQueue.main.async { imageViews[index]?.image = image }
                                    }
                                }.resume()
                            }
                        case .failure:
                            imageViews[index]?.image = UIImage(named: "grey_bg")
                        }
                    }
                }
            }
        }
    }
    
    private func fetchGoogleBook(volumeId: String, completion: @escaping (Result<BookF?, Error>) -> Void) {
        let baseUrlString = "https://www.googleapis.com/books/v1/volumes/\(volumeId)"
        guard let url = URL(string: baseUrlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.zeroByteResource)))
                return
            }

            do {
                let item = try JSONDecoder().decode(VolumeItem.self, from: data)
                if let volumeInfo = item.volumeInfo {
                    let book = BookF(
                        id: item.id,
                        title: volumeInfo.title,
                        subtitle: volumeInfo.subtitle ?? "",
                        authors: volumeInfo.authors ?? [],
                        description: volumeInfo.description ?? "",
                        averageRating: volumeInfo.averageRating ?? 0.0,
                        ratingsCount: volumeInfo.ratingsCount ?? 0,
                        imageLinks: volumeInfo.imageLinks,
                        previewLink: volumeInfo.previewLink ?? "",
                        pageCount: volumeInfo.pageCount ?? 0
                    )
                    completion(.success(book))
                } else {
                    completion(.success(nil))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

