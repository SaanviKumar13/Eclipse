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
        authorImage.image = author?.image
        
        authorImage.layer.cornerRadius = 40
        authorImage.clipsToBounds = true
        
        numberOfBooks.text = "50"
        numberOfReadingLists.text = "6"
        
        readingListLabel.numberOfLines = 0
        
        followButton.layer.cornerRadius = 10
        followButton.clipsToBounds = true
        
        guidedListButton.layer.cornerRadius = 10
        guidedListButton.clipsToBounds = true
        
        
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0: readingListView.alpha = 0
                allBooksView.alpha = 1
                break
        case 1: readingListView.alpha = 1
                allBooksView.alpha = 0
                break
        default: break
        }
    }
}
