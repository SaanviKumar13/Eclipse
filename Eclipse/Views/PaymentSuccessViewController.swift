import UIKit

class PaymentSuccessViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.7, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return view
    }()
    
    private let checkmarkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let successLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Payment Successful"
        label.textColor = .white
        label.textAlignment = .center // Added text alignment
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.alpha = 0
        return label
    }()
    
    private let checkmarkShapeLayer = CAShapeLayer()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Add views to hierarchy
        view.addSubview(containerView)
        containerView.addSubview(checkmarkView)
        containerView.addSubview(successLabel)
        
        setupConstraints()
        setupCheckmark()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 250),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            
            checkmarkView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            checkmarkView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -20),
            checkmarkView.widthAnchor.constraint(equalToConstant: 100),
            checkmarkView.heightAnchor.constraint(equalToConstant: 100),
            
            successLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            successLabel.topAnchor.constraint(equalTo: checkmarkView.bottomAnchor, constant: 20),
            successLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            successLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupCheckmark() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 50))
        path.addLine(to: CGPoint(x: 40, y: 70))
        path.addLine(to: CGPoint(x: 80, y: 30))
        
        checkmarkShapeLayer.path = path.cgPath
        checkmarkShapeLayer.strokeColor = UIColor.white.cgColor
        checkmarkShapeLayer.fillColor = nil
        checkmarkShapeLayer.lineWidth = 8
        checkmarkShapeLayer.lineCap = .round
        checkmarkShapeLayer.lineJoin = .round
        checkmarkShapeLayer.strokeEnd = 0
        
        checkmarkView.layer.addSublayer(checkmarkShapeLayer)
    }
    
    private func animateIn() {
        // Container animation
        UIView.animate(withDuration: 0.5,
                      delay: 0,
                      usingSpringWithDamping: 0.7,
                      initialSpringVelocity: 0.5,
                      options: .curveEaseOut) {
            self.containerView.transform = .identity
        }
        
        // Checkmark animation
        let checkmarkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkmarkAnimation.duration = 0.5
        checkmarkAnimation.fromValue = 0
        checkmarkAnimation.toValue = 1
        checkmarkAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        checkmarkAnimation.fillMode = .forwards
        checkmarkAnimation.isRemovedOnCompletion = false
        
        checkmarkShapeLayer.add(checkmarkAnimation, forKey: "checkmarkAnimation")
        
        // Label animation
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.successLabel.alpha = 1
        }
        
        // Auto-dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.animateOut()
        }
    }
    
    private func animateOut() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.alpha = 0
        }) { [weak self] _ in
            self?.dismiss(animated: false) {
                self?.showFeedbackScreen()
            }
        }
    }
    
    private func showFeedbackScreen() {
        guard let topVC = UIApplication.shared.windows.first?.rootViewController?.topMostViewController() else {
            return
        }
        
        let feedbackVC = FeedbackViewController()
        feedbackVC.modalPresentationStyle = .fullScreen
        topVC.present(feedbackVC, animated: true)
    }
}

// MARK: - UIViewController Extension

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presented = presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
}

