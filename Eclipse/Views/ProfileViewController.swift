import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    
    private let accountOptions = [
        "Edit Profile",
        "Notifications",
        "Book Support"
    ]
    
    private let actionOptions = [
        "Report a Problem",
        "Add Books to Profile",
        "Log Out"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "profile")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        let nameLabel = UILabel()
        if let user = Auth.auth().currentUser {
                    nameLabel.text = user.displayName ?? "No Name Available"
                } else {
                    nameLabel.text = "User not signed in"
                }
        nameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableHeaderView = UIView()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accountOptions.count
        case 1:
            return actionOptions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = accountOptions[indexPath.row]
        case 1:
            cell.textLabel?.text = actionOptions[indexPath.row]
        default:
            break
        }
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = .black
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            handleAccountOptionSelection(indexPath.row)
        case 1:
            handleActionOptionSelection(indexPath.row)
        default:
            break
        }
    }
    
    private func handleAccountOptionSelection(_ row: Int) {
        switch row {
        case 0:
            let editProfileVC = EditProfileViewController()
            editProfileVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(editProfileVC, animated: true)
        case 1:
            showNotificationConfirmationPopup()
        case 2:
            let bookSupportVC = BookSupportViewController()
            navigationController?.pushViewController(bookSupportVC, animated: true)
        default:
            break
        }
    }
    
    private func handleActionOptionSelection(_ row: Int) {
        switch row {
        case 0:
            let raiseProblemVC = RaiseProblemViewController()
            navigationController?.pushViewController(raiseProblemVC, animated: true)
        case 1:
            let searchVC = SearchViewController() // Navigate to SearchViewController
            navigationController?.pushViewController(searchVC, animated: true)
        case 2:
            showLogoutConfirmationPopup()
        default:
            break
        }
    }
    
    private func showNotificationConfirmationPopup() {
        let alertController = UIAlertController(
            title: "Enable Notifications",
            message: "Are you sure you want to turn on notifications?",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))
        
        alertController.addAction(UIAlertAction(
            title: "Enable",
            style: .default,
            handler: { [weak self] _ in
                print("Notifications enabled")
                let confirmationAlert = UIAlertController(
                    title: "Notifications Enabled",
                    message: "You will now receive notifications.",
                                    preferredStyle: .alert
                                )
                                confirmationAlert.addAction(UIAlertAction(
                                    title: "OK",
                                    style: .default,
                                    handler: nil
                                ))
                self?.present(confirmationAlert, animated: true, completion: nil)
            }
        ))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func showLogoutConfirmationPopup() {
        let alertController = UIAlertController(
            title: "Log Out",
            message: "Are you sure you want to log out of your account?",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))
        
        alertController.addAction(UIAlertAction(
            title: "Log Out",
            style: .destructive,
            handler: { [weak self] _ in
                do {
                    try Auth.auth().signOut()
                    let loginVC = LoginViewController()
                    let navController = UINavigationController(rootViewController: loginVC)
                    navController.modalPresentationStyle = .fullScreen
                    self?.view.window?.rootViewController = navController
                    self?.view.window?.makeKeyAndVisible()
                } catch let error as NSError {
                    print("Error signing out: \(error.localizedDescription)")
                    let errorAlert = UIAlertController(
                        title: "Error",
                        message: "Failed to log out. Please try again.",
                        preferredStyle: .alert
                    )
                    errorAlert.addAction(UIAlertAction(
                        title: "OK",
                        style: .default,
                        handler: nil
                    ))
                    self?.present(errorAlert, animated: true, completion: nil)
                }
            }
        ))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Account"
        case 1:
            return "Actions"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        
        switch section {
        case 0:
            titleLabel.text = "Account"
        case 1:
            titleLabel.text = "Actions"
        default:
            break
        }
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

