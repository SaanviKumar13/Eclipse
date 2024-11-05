//
//  CreateCollectionViewController.swift
//  Eclipse
//
//  Created by user@87 on 05/11/24.
//

import UIKit

class CreateCollectionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var privateSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "create_list")

        navigationController?.setNavigationBarHidden(false, animated: false)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "Error", message: "Collection name cannot be empty.")
            return
        }
        
        let description = descriptionTextField.text ?? ""
        let isPrivate = privateSwitch.isOn
        print("Name: \(name), Description: \(description), Private: \(isPrivate)")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

