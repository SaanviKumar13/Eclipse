import UIKit

protocol CustomBookTableViewCellDelegate: AnyObject {
    func didSelectBookmark(for book: BookF)
}

class CustomBookTableViewCell: UITableViewCell {

    var descriptionLabel: UILabel!
    var authorLabel: UILabel!
    var titleLabel: UILabel!
    var bookImage: UIImageView!
    var bookmarkButton: UIButton!

    weak var delegate: CustomBookTableViewCellDelegate?
    
    var book: BookF? {
        didSet {
            updateUI()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        descriptionLabel = UILabel()
        authorLabel = UILabel()
        titleLabel = UILabel()
        bookImage = UIImageView()
        bookmarkButton = UIButton(type: .system)

        setupUI()
        setupBookmarkButton()

        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
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
    }

    private func styleLabels() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        authorLabel.textColor = UIColor.gray
    }

    private func setupBookmarkButton() {
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
    }

    @objc private func bookmarkButtonTapped() {
        guard let book = book else { return }
        delegate?.didSelectBookmark(for: book)
    }

    private func updateUI() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.authors?.joined(separator: ", ") ?? "Unknown Author"
        descriptionLabel.text = book.description ?? "No description available."

        if let urlString = book.imageLinks?.thumbnail, let url = URL(string: urlString) {
            downloadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.bookImage.image = image ?? UIImage(named: "placeholder")
                }
            }
        } else {
            bookImage.image = UIImage(named: "placeholder")
        }
    }


    private func addSubviews() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bookImage)
        contentView.addSubview(bookmarkButton)
    }

    private func setupConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            bookImage.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bookImage.widthAnchor.constraint(equalToConstant: 60),
            bookImage.heightAnchor.constraint(equalToConstant: 80),

            bookmarkButton.topAnchor.constraint(equalTo: bookImage.topAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 30),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 30),
            bookmarkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}



