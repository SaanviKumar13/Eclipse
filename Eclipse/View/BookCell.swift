//
//  BookCell.swift
//  Eclipse
//
import UIKit

class BookCell: UITableViewCell {

    private let coverImageView = UIImageView()
    private let titleLabel = UILabel()
    private let lenderLabel = UILabel()
    private let priceLabel = UILabel()
    private let daysLeftLabel = UILabel()
    private let chatButton = UIButton(type: .system)
    private let returnButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        // Configure coverImageView
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.layer.cornerRadius = 8
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverImageView)

        // Configure labels
        titleLabel.font = .boldSystemFont(ofSize: 16)
        lenderLabel.font = .systemFont(ofSize: 14)
        priceLabel.font = .systemFont(ofSize: 14)
        daysLeftLabel.font = .systemFont(ofSize: 14)

        // Configure buttons
        chatButton.setImage(UIImage(systemName: "message"), for: .normal)
        returnButton.setTitle("Return", for: .normal)
        returnButton.setTitleColor(.systemBlue, for: .normal)

        // Stack view for labels
        let infoStackView = UIStackView(arrangedSubviews: [titleLabel, lenderLabel, priceLabel, daysLeftLabel])
        infoStackView.axis = .vertical
        infoStackView.spacing = 4
        infoStackView.alignment = .leading
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoStackView)

        // Create a vertical stack view for buttons
        let buttonStackView = UIStackView(arrangedSubviews: [chatButton, returnButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 4
        buttonStackView.alignment = .trailing
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonStackView)

        // Set constraints
        NSLayoutConstraint.activate([
            // coverImageView constraints
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            coverImageView.widthAnchor.constraint(equalToConstant: 60),
            coverImageView.heightAnchor.constraint(equalToConstant: 90),
            coverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            // infoStackView constraints
            infoStackView.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
            infoStackView.trailingAnchor.constraint(equalTo: buttonStackView.leadingAnchor, constant: -8),
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), // Start lower from top
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            // buttonStackView constraints
            buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            buttonStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])

        // Add bottom padding to increase space between cells
        contentView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 120).isActive = true // Adjust height to add space between cells
    }

    func configure(with book: Book) {
        titleLabel.text = book.title
        lenderLabel.text = "Lent to John Doe"
//        lenderLabel.text = "Lent to \(String(describing: book.lender))"
        priceLabel.text = String(describing: book.price ?? 0)
//        daysLeftLabel.text = book.daysLeft
        daysLeftLabel.text = "10"
        coverImageView.image = book.coverImageURL
    }
}
