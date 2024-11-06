//
//  LibraryViewController.swift
//  Eclipse
//
//  Created by user@87 on 29/10/24.
//

import UIKit

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var ReadingListView: UIView!
    @IBOutlet weak var AllBooksView: UIView!

    override func viewDidLoad() {
        title = "Library"
        super.viewDidLoad()
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0: ReadingListView.alpha = 1
                AllBooksView.alpha = 0
                break
        case 1: ReadingListView.alpha = 0
                AllBooksView.alpha = 1
                break
        default: break
        }
    }
}
