import UIKit

class LibraryViewController: UIViewController {

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All Books", "Reading List"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        return control
    }()

    private lazy var allBooksVC = AllBooksViewController()
    private lazy var readingListVC = ReadingListViewController()
    private var currentVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        view.backgroundColor = .systemBackground
        setupLayout()
        showViewController(allBooksVC)  // Default to AllBooksViewController
    }

    private func setupLayout() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func segmentDidChange(_ sender: UISegmentedControl) {
        let newVC = sender.selectedSegmentIndex == 0 ? allBooksVC : readingListVC
        showViewController(newVC)
    }

    private func showViewController(_ newVC: UIViewController) {
        if let currentVC = currentVC {
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }

        addChild(newVC)
        newVC.view.frame = view.bounds
        newVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newVC.view)
        view.sendSubviewToBack(newVC.view)

        NSLayoutConstraint.activate([
            newVC.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            newVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        newVC.didMove(toParent: self)
        currentVC = newVC
    }
}

