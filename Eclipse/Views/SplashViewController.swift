import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let isOnboarded = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        let hasSetPreferences = UserDefaults.standard.bool(forKey: "hasSetAuthorPreferences")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if isOnboarded && hasSetPreferences {
                self.navigateToMainScreen()
            } else {
                self.navigateToOnboardingFlow()
            }
        }
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#005C78")
        
        let eclipseLabel = UILabel()
        eclipseLabel.text = "Eclipse"
        eclipseLabel.font = UIFont.boldSystemFont(ofSize: 65)
        eclipseLabel.textColor = .white
        eclipseLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eclipseLabel)
        
        NSLayoutConstraint.activate([
            eclipseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eclipseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func navigateToMainScreen() {
        let mainTabBarController = ViewController()
        let window = UIApplication.shared.windows.first
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
    }

    private func navigateToOnboardingFlow() {
        let onboardingVC = OnboardingViewController()
        let navigationController = UINavigationController(rootViewController: onboardingVC)
        
        let window = UIApplication.shared.windows.first
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

