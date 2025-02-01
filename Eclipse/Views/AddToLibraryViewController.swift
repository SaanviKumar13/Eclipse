import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddToLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var book: BookF?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let addListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add New Custom List", for: .normal)
        button.addTarget(self, action: #selector(addCustomListTapped), for: .touchUpInside)
        return button
    }()
    
    var statusLists: [Status] = [.wantToRead, .currentlyReading, .finished, .didNotFinish]
    var customLists: [String: List] = [:]
    
    var selectedStatus: Status?
    var selectedCustomLists: Set<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCustomLists()
        setupNavigationBar()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(addListButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addListButton.topAnchor, constant: -10),
            
            addListButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addListButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Add to Library"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    private func fetchCustomLists() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userID).collection("customLists").getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error fetching custom lists: \(error)")
                return
            }
            
            if let snapshot = snapshot {
                self?.customLists = [:]
                for document in snapshot.documents {
                    let listName = document.documentID
                    self?.customLists[listName] = List(title: listName, bookIDs: [], isPrivate: false)
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func addCustomListTapped() {
        let alertController = UIAlertController(title: "New Custom List", message: "Enter the name of your new list.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "List name"
        }
        
        let createAction = UIAlertAction(title: "Create", style: .default) { [weak self] _ in
            guard let listName = alertController.textFields?.first?.text, !listName.isEmpty else { return }
            self?.createNewCustomList(named: listName)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func createNewCustomList(named listName: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        
        let db = Firestore.firestore()
        let newList = List(title: listName, bookIDs: [], isPrivate: false)
        
        db.collection("users").document(userID).collection("customLists").document(listName).setData(newList.toDictionary()) { [weak self] error in
            if let error = error {
                print("Error creating custom list: \(error)")
            } else {
                self?.fetchCustomLists()
            }
        }
    }
    
    @objc private func saveButtonTapped() {
        saveToUserBookmarks()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func saveToUserBookmarks() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        
        let db = Firestore.firestore()
        
        if let selectedStatus = selectedStatus, let book = book {
            let listRef = db.collection("users").document(userID).collection("lists").document(selectedStatus.rawValue)
            listRef.updateData([
                "bookIDs": FieldValue.arrayUnion([book.id]),
                "timestamp": FieldValue.serverTimestamp()
            ]) { error in
                if let error = error {
                    print("Error saving to status list: \(error)")
                } else {
                    print("Book saved to status list: \(selectedStatus.rawValue)")
                }
            }
        }
        
        for customListName in selectedCustomLists {
            if let book = book {
                let customListRef = db.collection("users").document(userID).collection("customLists").document(customListName)
                customListRef.updateData([
                    "bookIDs": FieldValue.arrayUnion([book.id]),
                    "timestamp": FieldValue.serverTimestamp()
                ]) { error in
                    if let error = error {
                        print("Error saving to custom list \(customListName): \(error)")
                    } else {
                        print("Book saved to custom list: \(customListName)")
                    }
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? statusLists.count : customLists.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Status Lists" : "Collections"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            let status = statusLists[indexPath.row]
            cell.textLabel?.text = status.rawValue
            cell.accessoryType = selectedStatus == status ? .checkmark : .none
        } else {
            let customListName = Array(customLists.keys)[indexPath.row]
            cell.textLabel?.text = customListName
            cell.accessoryType = selectedCustomLists.contains(customListName) ? .checkmark : .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedStatus = statusLists[indexPath.row]
        } else {
            let customListName = Array(customLists.keys)[indexPath.row]
            if selectedCustomLists.contains(customListName) {
                selectedCustomLists.remove(customListName)
            } else {
                selectedCustomLists.insert(customListName)
            }
        }
        tableView.reloadData()
    }
}

