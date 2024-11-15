//
//  BorrowViewController.swift
//  Eclipse
//
//  Created by admin48 on 09/11/24.
//

//import UIKit
//
//class BorrowView: UIView, UITableViewDelegate, UITableViewDataSource {
//    
//    private let tableView = UITableView()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupView() {
//        backgroundColor = .white
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(BookCell.self, forCellReuseIdentifier: "BookCell") // Register custom cell
//        addSubview(tableView)
//        
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//    
//    // MARK: - UITableViewDataSource
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5 // Number of borrowed books
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
//        cell.configure(with: mockBooks[indexPath.row])
//        return cell
//    }
//    
//    
//    
//    //           
//    //       
//}
