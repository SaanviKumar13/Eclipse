import UIKit

// Define the StatusBookTableViewCellDelegate protocol
protocol StatusBookTableViewCellDelegate: AnyObject {
    func didSelectKebabMenu(for book: BookF)
}

class StatusBookTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var kebabMenuButton: UIButton!
    
    weak var delegate: StatusBookTableViewCellDelegate? // Delegate reference
    
    var book: BookF? {
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
        authorLabel.text = book.authors?.joined(separator: ", ") ?? "Unknown Author"
        descriptionLabel.text = book.description ?? "No description available"
        
        // Load the book cover image from the URL
        if let imageURL = book.imageLinks?.thumbnail, let url = URL(string: imageURL) {
            bookImage.loadImage(from: url)
        } else {
            bookImage.image = UIImage(systemName: "book")
        }
    }
}

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

