//
//  CreateCollectionViewController.swift
//  Eclipse
//
//  Created by user@87 on 11/11/24.
//

import UIKit

class CreateCollectionViewController: UIViewController {

    private var imageView: UIImageView!
    private var descriptionTextField: UITextField!
    private var nameTextField: UITextField!
    private var privateSwitch: UISwitch!
    private var privacyInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        imageView = UIImageView(image: UIImage(named: "create_list"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        nameTextField = UITextField()
        nameTextField.placeholder = "Collection Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        descriptionTextField = UITextField()
        descriptionTextField.placeholder = "Description"
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextField)
        
        privateSwitch = UISwitch()
        privateSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(privateSwitch)
        
        privacyInfo = UILabel()
        privacyInfo.numberOfLines = 0
        privacyInfo.lineBreakMode = .byWordWrapping
        privacyInfo.text = "Other users will not be able to see your lists."
        privacyInfo.font = UIFont.systemFont(ofSize: 14)
        privacyInfo.textColor = .gray
        privacyInfo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(privacyInfo)
        
        navigationItem.title = "Create Collection"
        navigationItem.titleView?.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            privateSwitch.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            privateSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            privacyInfo.topAnchor.constraint(equalTo: privateSwitch.bottomAnchor, constant: 10),
            privacyInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            privacyInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "Error", message: "Collection name cannot be empty.")
            return
        }
        
        let description = descriptionTextField.text ?? ""
        let isPrivate = privateSwitch.isOn
        print("Name: \(name), Description: \(description), Private: \(isPrivate)")
        dismiss(animated: true, completion: nil)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
