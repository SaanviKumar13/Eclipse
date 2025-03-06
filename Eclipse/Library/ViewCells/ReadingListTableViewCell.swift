import UIKit

class ReadingListTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var privacyIndicator: UIImageView!
    var book1: UIImageView!
    var book2: UIImageView!
    var book3: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Initialize the UI elements programmatically
        titleLabel = UILabel()
        subtitleLabel = UILabel()
        privacyIndicator = UIImageView()
        book1 = UIImageView()
        book2 = UIImageView()
        book3 = UIImageView()
        
        // Set up the labels and images
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        privacyIndicator.translatesAutoresizingMaskIntoConstraints = false
        book1.translatesAutoresizingMaskIntoConstraints = false
        book2.translatesAutoresizingMaskIntoConstraints = false
        book3.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the UI elements to the content view
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(privacyIndicator)
        contentView.addSubview(book1)
        contentView.addSubview(book2)
        contentView.addSubview(book3)
        
        // Apply corner radius and clipsToBounds to the book images
        [book1, book2, book3].forEach { bookImageView in
            bookImageView.layer.cornerRadius = 10
            bookImageView.clipsToBounds = true
        }
        
        // Add constraints
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        // Add constraints for the title label
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        // Add constraints for the subtitle label
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        // Add constraints for the privacy indicator
        NSLayoutConstraint.activate([
            privacyIndicator.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            privacyIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            privacyIndicator.widthAnchor.constraint(equalToConstant: 20),
            privacyIndicator.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // Add constraints for the book images
        let booksStackView = UIStackView(arrangedSubviews: [book1, book2, book3])
        booksStackView.translatesAutoresizingMaskIntoConstraints = false
        booksStackView.axis = .horizontal
        booksStackView.spacing = 10
        booksStackView.alignment = .center
        contentView.addSubview(booksStackView)
        
        NSLayoutConstraint.activate([
            booksStackView.topAnchor.constraint(equalTo: privacyIndicator.bottomAnchor, constant: 10),
            booksStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            booksStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            booksStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            book1.widthAnchor.constraint(equalToConstant: 60),
            book1.heightAnchor.constraint(equalToConstant: 80),
            book2.widthAnchor.constraint(equalToConstant: 60),
            book2.heightAnchor.constraint(equalToConstant: 80),
            book3.widthAnchor.constraint(equalToConstant: 60),
            book3.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}



