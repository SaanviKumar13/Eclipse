//
//  LibraryViewController.swift
//  Eclipse
//
//  Created by user@87 on 09/11/24.
//
import UIKit

class LibraryViewController: UIViewController {
    
    let segmentedControl = UISegmentedControl(items: ["All Books", "Reading List"])
    let allBooksVC = AllBooksViewController()
    let readingListVC = ReadingListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSegmentedControl()
        setUpViewControllers()
    }
    
    private func setUpSegmentedControl() {
        view.addSubview(segmentedControl)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.tintColor = UIColor.systemGray6
        segmentedControl.selectedSegmentTintColor = UIColor.systemGray6
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor.systemGray.cgColor
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .thin)
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ]
        
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 250),
            segmentedControl.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func setUpViewControllers() {
        add(asChildViewController: allBooksVC)
    }
    
    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            swapViewController(from: readingListVC, to: allBooksVC)
        } else {
            swapViewController(from: allBooksVC, to: readingListVC)
        }
    }
    
    private func swapViewController(from oldViewController: UIViewController, to newViewController: UIViewController) {
        remove(asChildViewController: oldViewController)
        add(asChildViewController: newViewController)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

