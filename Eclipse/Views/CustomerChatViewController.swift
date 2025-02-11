//
//  customerChatViewController.swift
//  Eclipse
//
//  Created by admin48 on 19/11/24.
//

import UIKit

class customerChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageInputViewDelegate {
    
    private let tableView = UITableView()
    private var messages: [Messages] = [
        Messages(text: "I've received the book, but it is damaged.", isFromUser: true, isImage: false, imageName: nil),
        Messages(text: "We're sorry to hear that, we're here to help. To process your request we will require a picture of the damaged book and details of the damage.", isFromUser: false, isImage: false, imageName: nil),
        Messages(text: "", isFromUser: true, isImage: true, imageName: "damaged_book")
    ]
    private let messageInputView = MessageInputView()
    private let messageTextField = UITextField()
    private let messageInputBar = UIView()
    private var isFirstMessage = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
    }
    private func setupNavigation() {
        title = "Customer Support"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Chat with us to resolve your issue"
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .systemGray
        titleLabel.textAlignment = .center
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Today 9:41"
        subtitleLabel.font = .systemFont(ofSize: 11)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.textAlignment = .center
        headerView.addSubview(subtitleLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(customerMessageCell.self, forCellReuseIdentifier: "MessageCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        messageInputBar.translatesAutoresizingMaskIntoConstraints = false
        messageInputBar.backgroundColor = .white
        messageInputBar.layer.borderWidth = 1
        messageInputBar.layer.borderColor = UIColor.systemGray5.cgColor
        view.addSubview(messageInputBar)
        
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.placeholder = "Message"
        messageTextField.borderStyle = .none
        messageTextField.returnKeyType = .send
        messageTextField.delegate = self
        messageInputBar.addSubview(messageTextField)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputBar.topAnchor),
            
            messageInputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageInputBar.heightAnchor.constraint(equalToConstant: 60),
            
            messageTextField.leadingAnchor.constraint(equalTo: messageInputBar.leadingAnchor, constant: 16),
            messageTextField.centerYAnchor.constraint(equalTo: messageInputBar.centerYAnchor),
            
 
        ])
    
        let cameraIcon = UIImage(systemName: "camera")
        let cameraButton = UIBarButtonItem(image: cameraIcon, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = cameraButton
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? customerMessageCell else {
            return UITableViewCell()
        }
        cell.configure(with: messages[indexPath.row])
        return cell
    }
    
    func messageInputView(_ view: MessageInputView, didSendMessage text: String) {
        let userMessage = Messages(text: text, isFromUser: true, isImage: false, imageName: nil)
        messages.append(userMessage)
        tableView.reloadData()
        messageInputView.textView.text = ""
        
        if messages.count == 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                let systemMessage = Messages(
                    text: " Thank you! I've received the image. We'll review the damage and offer you a refund based on our policy. This may take up to 2 business days.You'll receive an update via email oncethe refund is issued. Thank you for your patience. Is there anything else I can assist you with?",
                    isFromUser: false,
                    isImage: false,
                    imageName: nil
                )
                self.messages.append(systemMessage)
                self.tableView.reloadData()
            }
        }
    }
        @objc private func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
   

    }

    extension customerChatViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard let text = textField.text, !text.isEmpty else { return true }
            
            messages.append(Messages(text: text, isFromUser: true,isImage: false, imageName: nil))
            tableView.reloadData()
            textField.text = nil
            
            if isFirstMessage {
                isFirstMessage = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                    guard let self = self else { return }
                    self.messages.append(Messages(text: "Thank you! I’ve received the image. We’ll review the damage and offer you a refund based on our policy. This may take up to 2 business days.You’ll receive an update via email once the refund is issued.", isFromUser: false,isImage: false, imageName: nil))
                    self.tableView.reloadData()
                }
            }
            
            return true
        }
    
    }

