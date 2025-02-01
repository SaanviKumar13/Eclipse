import UIKit


class ViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchBarContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Discover your next read..."
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .secondarySystemBackground
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        let image = UIImage(named: "profile")
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let featuredBooks: FeaturedBooksView = {
        let view = FeaturedBooksView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var favoritesCollectionView: UICollectionView = {
        let layout = createFavoritesLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteBookCell.self, forCellWithReuseIdentifier: FavoriteBookCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var topRentersCollectionView: UICollectionView = {
        let layout = createTopRentersLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TopRenterCell.self, forCellWithReuseIdentifier: TopRenterCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private lazy var undiscoveredGemsCollectionView: UICollectionView = {
        let layout = createUndiscoveredGemsLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UndiscoveredGemCell.self, forCellWithReuseIdentifier: UndiscoveredGemCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        setupConstraints()
        applyVisualEffects()
    }
    private func setupUI() {
        view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        searchBarContainer.addSubview(profileButton)
        
        contentView.addSubview(featuredBooks)
        contentView.addSubview(createSectionHeader(title: " Your Favorites", tag: 1))
        contentView.addSubview(favoritesCollectionView)
        contentView.addSubview(createSectionHeader(title: " Top Renters", tag: 2))
        contentView.addSubview(topRentersCollectionView)
        contentView.addSubview(createSectionHeader(title: "Undiscovered Gems", tag: 3))
        contentView.addSubview(undiscoveredGemsCollectionView)
    }
    
    private func configureNavigationBar() {
        title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
    }
    
    private func createSectionHeader(title: String, tag: Int) -> UIView {
        let containerView = UIView()
        containerView.tag = tag
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        button.tag = tag
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            button.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            containerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return containerView
    }
    
    private func setupConstraints() {
        let favoritesHeader = view.viewWithTag(1)!
        let topRentersHeader = view.viewWithTag(2)!
        let undiscoveredGemsHeader = view.viewWithTag(3)!
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            searchBarContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchBarContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchBarContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchBarContainer.heightAnchor.constraint(equalToConstant: 60),
            
            searchBar.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor, constant: 8),
            searchBar.centerYAnchor.constraint(equalTo: searchBarContainer.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -8),
            
            profileButton.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor, constant: -16),
            profileButton.centerYAnchor.constraint(equalTo: searchBarContainer.centerYAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            
            featuredBooks.topAnchor.constraint(equalTo: searchBarContainer.bottomAnchor, constant: 16),
            featuredBooks.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuredBooks.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            featuredBooks.heightAnchor.constraint(equalToConstant: 250),
            
            favoritesHeader.topAnchor.constraint(equalTo: featuredBooks.bottomAnchor, constant: 24),
            favoritesHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favoritesHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            favoritesCollectionView.topAnchor.constraint(equalTo: favoritesHeader.bottomAnchor),
            favoritesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favoritesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoritesCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            topRentersHeader.topAnchor.constraint(equalTo: favoritesCollectionView.bottomAnchor, constant: 12),
            topRentersHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topRentersHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            topRentersCollectionView.topAnchor.constraint(equalTo: topRentersHeader.bottomAnchor),
            topRentersCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topRentersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topRentersCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            undiscoveredGemsHeader.topAnchor.constraint(equalTo: topRentersCollectionView.bottomAnchor, constant: 12),
            undiscoveredGemsHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            undiscoveredGemsHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            undiscoveredGemsCollectionView.topAnchor.constraint(equalTo: undiscoveredGemsHeader.bottomAnchor),
            undiscoveredGemsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            undiscoveredGemsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            undiscoveredGemsCollectionView.heightAnchor.constraint(equalToConstant: 250),
           
            undiscoveredGemsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            
        ])
    }
    
    private func applyVisualEffects() {
        searchBarContainer.layer.shadowColor = UIColor.black.cgColor
        searchBarContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchBarContainer.layer.shadowRadius = 8
        searchBarContainer.layer.shadowOpacity = 0.1
        
        
        featuredBooks.layer.shadowColor = UIColor.black.cgColor
        featuredBooks.layer.shadowOffset = CGSize(width: 0, height: 2)
        featuredBooks.layer.shadowRadius = 8
        featuredBooks.layer.shadowOpacity = 0.1
    }
    
    private func createUndiscoveredGemsLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(250)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    private func createFavoritesLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                              heightDimension: .fractionalHeight(0.9))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func createTopRentersLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                return UICollectionViewCompositionalLayout(section: section)
            }
            
            @objc private func profileButtonTapped() {
                let profileVC = ProfileViewController()
                profileVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(profileVC, animated: true)
            }
            
            @objc private func seeAllButtonTapped(_ sender: UIButton) {
                
                print("See all tapped for section: \(sender.tag)")
            }
        }

        extension ViewController: UICollectionViewDataSource {
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                if collectionView == favoritesCollectionView {
                    return mockBooks.count
                } else if collectionView == undiscoveredGemsCollectionView {
                    return undiscoveredGems.count
                } else if collectionView == topRentersCollectionView {
                    return topRenters.count
                }
                return 0
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                if collectionView == favoritesCollectionView {
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: FavoriteBookCell.identifier,
                        for: indexPath
                    ) as? FavoriteBookCell else {
                        return UICollectionViewCell()
                    }
                    
                    let book = mockBooks[indexPath.item % mockBooks.count]
                    cell.configure(with: book)
                    return cell
                } else if collectionView == undiscoveredGemsCollectionView {
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: UndiscoveredGemCell.identifier,
                        for: indexPath
                    ) as? UndiscoveredGemCell else {
                        return UICollectionViewCell()
                    }
                    
                    let book = mockBooks[indexPath.item % mockBooks.count]
                    cell.configure(with: book)
                    return cell
                } else if collectionView == topRentersCollectionView {
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TopRenterCell.identifier,
                        for: indexPath
                    ) as? TopRenterCell else {
                        return UICollectionViewCell()
                    }
                    
                    let mockRenter = topRenters[indexPath.item % topRenters.count]
                    cell.configure(with: mockRenter)
                    return cell
                }
                
                return UICollectionViewCell()
            }
        }

        extension ViewController: UICollectionViewDelegate {
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                if collectionView == favoritesCollectionView {
                    let selectedBook = mockBooks[indexPath.item]
//                    let bookVC = BookViewController(book: selectedBook)
//                    navigationController?.pushViewController(bookVC, animated: true)
                } else if collectionView == topRentersCollectionView {
                    let renter = topRenters[indexPath.item]
                    let renterProfileVC = RentersProfileViewController()
                    renterProfileVC.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(renterProfileVC, animated: true)
                }
                else if collectionView == self.undiscoveredGemsCollectionView{
                    let selectedBook = mockBooks[indexPath.item]
//                    let bookVC = BookViewController(book: selectedBook)
//                    navigationController?.pushViewController(bookVC, animated: true)
                }
            }
        }

        extension ViewController: UISearchBarDelegate {
            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                print("Search text changed: \(searchText)")
            }
            
            func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                searchBar.resignFirstResponder()
                if let searchText = searchBar.text {
                    print("Perform search for: \(searchText)")
                }
            }
        }

        class FavoriteBookCell: UICollectionViewCell {
            static let identifier = "FavoriteBookCell"
            
            private let coverImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.contentMode = .scaleToFill
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 8
                imageView.backgroundColor = .systemGray5
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                setupUI()
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            private func setupUI() {
                contentView.backgroundColor = .systemBackground
                contentView.layer.cornerRadius = 12
                contentView.layer.shadowColor = UIColor.black.cgColor
                contentView.layer.shadowOpacity = 0.1
                contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
                contentView.layer.shadowRadius = 4
                
                contentView.addSubview(coverImageView)
                
                NSLayoutConstraint.activate([
                    coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                    coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                    coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                    coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8), // Added bottom constraint
                    coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 1.5)
                ])
            }
            
            func configure(with book: Book) {
                coverImageView.image = book.coverImageURL
            }
        }

        class TopRenterCell: UICollectionViewCell {
            static let identifier = "TopRenterCell"
            
            private let avatarImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.backgroundColor = .systemGray5
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            
            private let nameLabel: UILabel = {
                let label = UILabel()
                label.font = .systemFont(ofSize: 14, weight: .medium)
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            private let booksCountLabel: UILabel = {
                let label = UILabel()
                label.font = .systemFont(ofSize: 12, weight: .regular)
                label.textColor = .secondaryLabel
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                setupUI()
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            private func setupUI() {
                contentView.addSubview(avatarImageView)
                contentView.addSubview(nameLabel)
                contentView.addSubview(booksCountLabel)
                
                avatarImageView.layer.cornerRadius = 30
                
                NSLayoutConstraint.activate([
                    avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    avatarImageView.widthAnchor.constraint(equalToConstant: 60),
                    avatarImageView.heightAnchor.constraint(equalToConstant: 60),
                    
                    nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4),
                    nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    
                    booksCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
                    booksCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    booksCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                ])
            }
            
            func configure(with renter: TopRenter) {
                nameLabel.text = renter.name
                booksCountLabel.text = "\(renter.booksRented) books"
                avatarImageView.image = UIImage(named: renter.avatar)
            }
        }

        class FeaturedBooksView: UIView {
            private let pageControl: UIPageControl = {
                let control = UIPageControl()
                control.currentPageIndicatorTintColor = .systemBlue
                control.pageIndicatorTintColor = .systemGray4
                control.translatesAutoresizingMaskIntoConstraints = false
                return control
            }()
            
            private lazy var collectionView: UICollectionView = {
                let layout = createLayout()
                let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                collectionView.backgroundColor = .systemBackground
                collectionView.delegate = self
                collectionView.dataSource = self
                collectionView.isPagingEnabled = true
                collectionView.showsHorizontalScrollIndicator = false
                collectionView.register(FeaturedBookCell.self, forCellWithReuseIdentifier: FeaturedBookCell.identifier)
                collectionView.translatesAutoresizingMaskIntoConstraints = false
                return collectionView
            }()
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                setupUI()
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            private func setupUI() {
                backgroundColor = .systemBackground
                layer.cornerRadius = 12
                
                addSubview(collectionView)
                addSubview(pageControl)
                
                pageControl.numberOfPages = featuredBooks.count
                
                NSLayoutConstraint.activate([
                    collectionView.topAnchor.constraint(equalTo: topAnchor),
                    collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -8),
                    
                    pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
                    pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                    pageControl.heightAnchor.constraint(equalToConstant: 20)
                ])
            }
            
            private func createLayout() -> UICollectionViewLayout {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                
                return UICollectionViewCompositionalLayout(section: section)
            }
        }

        extension FeaturedBooksView: UICollectionViewDataSource, UICollectionViewDelegate {
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return featuredBooks.count
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FeaturedBookCell.identifier,
                    for: indexPath
                ) as? FeaturedBookCell else {
                    return UICollectionViewCell()
                }
                
                let book = mockBooks[indexPath.item % mockBooks.count]
                cell.configure(with: book)
                return cell
            }
            
            func scrollViewDidScroll(_ scrollView: UIScrollView) {
                let width = scrollView.frame.width
                guard width > 0 else { return }
                let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
                pageControl.currentPage = currentPage
            }
        }

        class UndiscoveredGemCell: UICollectionViewCell {
            static let identifier = "UndiscoveredGemCell"
            
            private let containerView: UIView = {
                let view = UIView()
                view.backgroundColor = .systemBackground
                view.layer.cornerRadius = 12
                view.layer.shadowColor = UIColor.black.cgColor
                view.layer.shadowOpacity = 0.1
                view.layer.shadowOffset = CGSize(width: 0, height: 2)
                view.layer.shadowRadius = 4
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            private let coverImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 12
                imageView.backgroundColor = .systemGray6
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            
            private let titleLabel: UILabel = {
                let label = UILabel()
                label.font = .systemFont(ofSize: 18, weight: .bold)
                label.numberOfLines = 2
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            private let authorLabel: UILabel = {
                let label = UILabel()
                label.font = .systemFont(ofSize: 14, weight: .medium)
                label.textColor = .secondaryLabel
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            private let descriptionLabel: UILabel = {
                let label = UILabel()
                label.font = .systemFont(ofSize: 12, weight: .regular)
                label.textColor = .secondaryLabel
                label.numberOfLines = 3
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            private let ratingContainer: UIStackView = {
                    let stack = UIStackView()
                    stack.axis = .horizontal
                    stack.spacing = 4
                    stack.alignment = .center
                    stack.translatesAutoresizingMaskIntoConstraints = false
                    return stack

                }()
            
            override init(frame: CGRect) {
                    super.init(frame: frame)
                    setupUI()
                }

                required init?(coder: NSCoder) {
                    fatalError("init(coder:) has not been implemented")
                }
            
            private func setupUI() {
                contentView.addSubview(containerView)
                
                containerView.addSubview(coverImageView)
                containerView.addSubview(titleLabel)
                containerView.addSubview(authorLabel)
                containerView.addSubview(descriptionLabel)
                containerView.addSubview(ratingContainer)
                
                NSLayoutConstraint.activate([
                    containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    
                    coverImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                    coverImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
                    coverImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
                    coverImageView.widthAnchor.constraint(equalToConstant: 150),
                    
                    titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                    titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
                    titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                    
                    authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                    authorLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
                    authorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                    
                    descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
                    descriptionLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
                    descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                    ratingContainer.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8), // Position below description
                                ratingContainer.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
                                ratingContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
                       
                ])
            }
            
            func configure(with book: Book) {
                coverImageView.image = book.coverImageURL
                titleLabel.text = book.title
                authorLabel.text = book.author.name
                descriptionLabel.text = book.description
                
                ratingContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }

                        let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
                        starImageView.tintColor = .systemYellow
                        starImageView.setContentHuggingPriority(.required, for: .horizontal)

                        let ratingLabel = UILabel()
                        ratingLabel.text = String(format: "%.1f", book.rating) // Or use goodreadsRating if you prefer
                        ratingLabel.font = .systemFont(ofSize: 14, weight: .medium)
                        ratingLabel.textColor = .label

                        ratingContainer.addArrangedSubview(starImageView)
                        ratingContainer.addArrangedSubview(ratingLabel)
            }
        }

 class FeaturedBookCell: UICollectionViewCell {
    static let identifier = "FeaturedBookCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.black.withAlphaComponent(0.0).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        layer.locations = [0.5, 1.0]
        return layer
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = containerView.bounds
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.layer.addSublayer(gradientLayer)
        
        containerView.addSubview(coverImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(authorLabel)
        containerView.addSubview(ratingContainer)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            coverImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -8),
            
            authorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            authorLabel.bottomAnchor.constraint(equalTo: ratingContainer.topAnchor, constant: -8),
            
            ratingContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            ratingContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.author.name
        coverImageView.image = book.coverImageURL
        
        ratingContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        starImageView.tintColor = .systemYellow
        starImageView.setContentHuggingPriority(.required, for: .horizontal)
        
        let ratingLabel = UILabel()
        ratingLabel.text = String(format: "%.1f", book.rating)
        ratingLabel.font = .systemFont(ofSize: 14, weight: .medium)
        ratingLabel.textColor = .white
        
        ratingContainer.addArrangedSubview(starImageView)
        ratingContainer.addArrangedSubview(ratingLabel)
    }
    
}

