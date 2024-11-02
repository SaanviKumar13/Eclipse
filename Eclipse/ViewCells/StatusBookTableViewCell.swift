//
//  StatusBookTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 02/11/24.
//
import UIKit

class StatusBookTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var kebabMenuButton: UIButton!
    weak var delegate: StatusBookTableViewCellDelegate?
    var book: Book? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        bookImage.layer.cornerRadius = 10
        bookImage.layer.masksToBounds = true
        bookImage.layer.borderWidth = 1.0
        bookImage.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 4
        
        styleLabels()
        setupKebabMenuButton()
    }

    private func styleLabels() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        authorLabel.textColor = UIColor.gray
    }
    private func setupKebabMenuButton() {
        kebabMenuButton.addTarget(self, action: #selector(kebabMenuButtonTapped), for: .touchUpInside)
    }


      @objc private func kebabMenuButtonTapped() {
          guard let book = book else { return }
          delegate?.didSelectKebabMenu(for: book)
      }
      

    private func updateUI() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.author.name
        descriptionLabel.text = book.description
        bookImage.image = book.coverImageURL ?? UIImage(systemName: "book")
    }

}
