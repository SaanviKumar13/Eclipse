//
//  AuthorBookTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 16/11/24.
//

import UIKit

class AuthorBookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var seriesInfo: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var rating: UILabel!
    
    var bookmarkButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookImage.layer.cornerRadius = 10
        bookImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func bookmarkButtonAction(_ sender: Any) {
    }
}
