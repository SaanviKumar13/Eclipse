//
//  AllBooksViewController.swift
//  Eclipse
//
//  Created by user@87 on 30/10/24.
//

import UIKit

class AllBooksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.item]
        cell.categoryLabel.text = category.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 80, height: 120)
       }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(categories)
        collectionView.dataSource = self
        collectionView.delegate = self
               
               // Configure collection view layout for horizontal scrolling
               if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.scrollDirection = .horizontal
               }
    }

}
