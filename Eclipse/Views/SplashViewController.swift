import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // Check UserDefaults to see if onboarding and preferences are set
        let isOnboarded = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        let hasSetPreferences = UserDefaults.standard.bool(forKey: "hasSetAuthorPreferences")

        // Simulate a delay before checking if user has completed onboarding
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if isOnboarded && hasSetPreferences {
                self.navigateToMainScreen() // Go to main content
            } else {
                self.navigateToOnboardingFlow() // Start onboarding if not completed
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
        // Code to navigate to the main screen (Tab Bar or main content)
        let mainTabBarController = ViewController() // Replace with your main screen
        let window = UIApplication.shared.windows.first
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
    }

    private func navigateToOnboardingFlow() {
        // Start the onboarding flow if not completed
        let onboardingVC = OnboardingViewController()
        let navigationController = UINavigationController(rootViewController: onboardingVC)
        
        let window = UIApplication.shared.windows.first
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

