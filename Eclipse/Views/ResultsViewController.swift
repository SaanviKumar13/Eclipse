//
//  ResultsViewController.swift
//  Eclipse
//
//  Created by user@87 on 15/11/24.
//

import UIKit

class ResultsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var results: [Book]!

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        results = sampleResults
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultsCell", for: indexPath) as? ResultsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let result = results[indexPath.item]
        cell.bookImage.image = result.coverImageURL
        cell.title.text = result.title
        cell.desc.text = result.description
        
        return cell
    }

    @IBAction func menuButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Menu", message: "Did you find the book recommendations helpful?", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            print("User found recommendations helpful")
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
            print("User did not find recommendations helpful")
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            popoverController.sourceRect = (sender as? UIView)?.bounds ?? CGRect.zero
        }

        present(alertController, animated: true, completion: nil)
    }

}
