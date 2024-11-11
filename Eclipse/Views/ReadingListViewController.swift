import UIKit

class StatusListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reading Lists"
        setupTableView()
        loadReadingLists()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReadingListCell.self, forCellReuseIdentifier: "ReadingListCell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    private func loadReadingLists() {
        readingLists = statusLists
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingListCell", for: indexPath) as? ReadingListCell else {
            return UITableViewCell()
        }

        let readingList = readingLists[indexPath.row]
        cell.configure(with: readingList)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedReadingList = readingLists[indexPath.row]
        let booksVC = BooksViewController(readingList: selectedReadingList)
        navigationController?.pushViewController(booksVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class CustomListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private var customReadingLists: [ReadingList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reading Lists"
        setupTableView()
        loadCustomReadingLists()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReadingListCell.self, forCellReuseIdentifier: "ReadingListCell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    private func loadCustomReadingLists() {
        customReadingLists = Array(customLists.values)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customReadingLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingListCell", for: indexPath) as? ReadingListCell else {
            return UITableViewCell()
        }

        let customReadingList = customReadingLists[indexPath.row]
        cell.configure(with: customReadingList)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedReadingList = customReadingLists[indexPath.row]
        let booksVC = BooksViewController(readingList: selectedReadingList)
        navigationController?.pushViewController(booksVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc private func createNewCollectionTapped() {
        let createVC = CreateCollectionViewController()
        let navController = UINavigationController(rootViewController: createVC)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: true, completion: nil)
    }
}

class ReadingListCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let privacyIndicator = UIImageView()
    private let bookImageViews = (1 ... 3).map { _ in UIImageView() }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Set up labels, image views, and other UI elements
    }

    func configure(with readingList: ReadingList) {
        titleLabel.text = readingList.title
        subtitleLabel.text = readingList.bookIDs.isEmpty ? "No books available" : "\(readingList.bookIDs.count) books"
        privacyIndicator.image = readingList.isPrivate ? UIImage(systemName: "lock.fill") : UIImage(systemName: "network")

        // Load and configure book cover images
    }
}

class BooksViewController: UIViewController {
    private let readingList: ReadingList

    init(readingList: ReadingList) {
        self.readingList = readingList
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = readingList.title
        // Set up UI to display the books in the reading list
    }
}

class CreateCollectionViewController: UIViewController {
    // Implement the UI and functionality for creating a new custom reading list
}

struct ReadingList {
    let title: String
    var bookIDs: [String]
    let isPrivate: Bool
}

// Provided data
var statusLists: [ReadingList] = [
    ReadingList(title: "Want To Read", bookIDs: [], isPrivate: false),
    ReadingList(title: "Currently Reading", bookIDs: [], isPrivate: false),
    ReadingList(title: "Finished", bookIDs: [], isPrivate: false),
    ReadingList(title: "Did Not Finish", bookIDs: [], isPrivate: false)
]

var customLists: [String: ReadingList] = [
    "Custom List 1": ReadingList(title: "Custom List 1", bookIDs: [], isPrivate: false),
    "Custom List 2": ReadingList(title: "Custom List 2", bookIDs: [], isPrivate: true),
    "Custom List 3": ReadingList(title: "Custom List 3", bookIDs: [], isPrivate: false)
]

var mockBooks: [Book] = [
    // Mock book data
]
