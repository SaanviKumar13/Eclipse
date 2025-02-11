//
//  ReadingListTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 01/11/24.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var privacyIndicator: UIImageView!
    @IBOutlet weak var book1: UIImageView!
    @IBOutlet weak var book2: UIImageView!
    @IBOutlet weak var book3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        book1.layer.cornerRadius = 10
        book2.layer.cornerRadius = 10
        book3.layer.cornerRadius = 10
        
        book1.clipsToBounds = true
        book2.clipsToBounds = true
        book3.clipsToBounds = true
    }
}
