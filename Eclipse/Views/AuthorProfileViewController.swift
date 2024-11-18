//
//  AuthorProfileViewController.swift
//  Eclipse
//
//  Created by user@87 on 16/11/24.
//

import UIKit

class AuthorProfileViewController: UIViewController {
    
    var author: Author?

    @IBOutlet weak var guidedListButton: UIButton!
    @IBOutlet weak var readingListLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var numberOfReadingLists: UILabel!
    @IBOutlet weak var numberOfBooks: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var readingListView: UIView!
    @IBOutlet weak var allBooksView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()

        if let author = author {
            navigationItem.title = author.name
        }
    }
    
    func setView(){
        guard let author = author else { return }
        
        authorImage.image = author.image
        authorImage.layer.cornerRadius = 40
        authorImage.clipsToBounds = true
        
        numberOfBooks.text = "50"  // Or pass actual data
        numberOfReadingLists.text = "6"  // Or pass actual data
        
        readingListLabel.numberOfLines = 0
        
        followButton.layer.cornerRadius = 10
        followButton.clipsToBounds = true
        
        guidedListButton.layer.cornerRadius = 10
        guidedListButton.clipsToBounds = true
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            readingListView.alpha = 0
            allBooksView.alpha = 1
        case 1:
            readingListView.alpha = 1
            allBooksView.alpha = 0
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAuthorBooks" || segue.identifier == "showGuidedList" {
            if let destinationVC = segue.destination as? AuthorBooksViewController {
                destinationVC.author = self.author
            } else if let destinationVC = segue.destination as? GuidedListViewController {
                destinationVC.author = self.author
            }
        }
    }

}
