import UIKit
import PhotosUI

class EditProfileViewController: UIViewController, PHPickerViewControllerDelegate, UINavigationControllerDelegate {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dobLabel: UILabel = createLabel(withText: "Date of Birth: 5 Aug 2000")
    private let emailLabel: UILabel = createLabel(withText: "Email: john.doe@email.com")
    private let phoneLabel: UILabel = createLabel(withText: "Phone: 9872664287")
    private let passwordLabel: UILabel = createLabel(withText: "Password: ********")

    private static func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createInfoBox(with label: UILabel) -> UIView {
        let boxView = UIView()
        boxView.layer.borderColor = UIColor.systemGray4.cgColor
        boxView.layer.borderWidth = 1
        boxView.layer.cornerRadius = 8
        boxView.translatesAutoresizingMaskIntoConstraints = false
        
        boxView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -12)
        ])
        return boxView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupNavigationBar()
        setupUI()
        setupProfileImageTapGesture()
    }

    func setupNavigationBar() {
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editProfileTapped))
        navigationItem.rightBarButtonItem = editButton
    }

    func setupUI() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)

        let dobBox = createInfoBox(with: dobLabel)
        let emailBox = createInfoBox(with: emailLabel)
        let phoneBox = createInfoBox(with: phoneLabel)
        let passwordBox = createInfoBox(with: passwordLabel)

        view.addSubview(dobBox)
        view.addSubview(emailBox)
        view.addSubview(phoneBox)
        view.addSubview(passwordBox)

        nameLabel.text = "John Doe"

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            dobBox.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            dobBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dobBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dobBox.heightAnchor.constraint(equalToConstant: 60),

            emailBox.topAnchor.constraint(equalTo: dobBox.bottomAnchor, constant: 15),
            emailBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailBox.heightAnchor.constraint(equalToConstant: 60),

            phoneBox.topAnchor.constraint(equalTo: emailBox.bottomAnchor, constant: 15),
            phoneBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneBox.heightAnchor.constraint(equalToConstant: 60),

            passwordBox.topAnchor.constraint(equalTo: phoneBox.bottomAnchor, constant: 15),
            passwordBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordBox.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    func setupProfileImageTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func changeProfileImage() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 1
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let result = results.first else { return }

        if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                DispatchQueue.main.async {
                    if let selectedImage = image as? UIImage {
                        self?.profileImageView.image = selectedImage
                    }
                }
            }
        }
    }

    @objc func editProfileTapped() {
        print("Edit Profile button tapped")
    }
}

