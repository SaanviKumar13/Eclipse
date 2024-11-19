//
//  RatingPopupView.swift
//  Eclipse
//
//  Created by admin48 on 17/11/24.
//

import UIKit

class RatingPopupView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rate this Seller"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let starsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = UIColor(hex: "005C78")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    private let overallRatingStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    private let overallRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "Overall Rating"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let staticRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.0"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let basedOnLabel: UILabel = {
        let label = UILabel()
        label.text = "Based on 20 reviews"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let ratingsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .fill
        return stack
    }()
    
    private var selectedRating: Int = 0
    private var completion: ((Int) -> Void)?
    
    init(completion: @escaping (Int) -> Void) {
        self.completion = completion
        super.init(frame: .zero)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(starsStackView)
        containerView.addSubview(overallRatingStackView)
        containerView.addSubview(ratingsStackView)
        containerView.addSubview(submitButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        overallRatingStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingsStackView.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        overallRatingStackView.addArrangedSubview(overallRatingLabel)
        overallRatingStackView.addArrangedSubview(staticRatingLabel)
        overallRatingStackView.addArrangedSubview(basedOnLabel)
        
        for i in 1...5 {
            let starButton = UIButton(type: .system)
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            starButton.tintColor = UIColor(hex: "005C78")
            starButton.tag = i
            starButton.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
            starsStackView.addArrangedSubview(starButton)
        }
        
        addRatingBarRow(to: ratingsStackView, label: "Good", barWidthMultiplier: 0.8)
        addRatingBarRow(to: ratingsStackView, label: "Average", barWidthMultiplier: 0.5)
        addRatingBarRow(to: ratingsStackView, label: "Poor", barWidthMultiplier: 0.2)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 350),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            starsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            starsStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            overallRatingStackView.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: 16),
            overallRatingStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            ratingsStackView.topAnchor.constraint(equalTo: overallRatingStackView.bottomAnchor, constant: 16),
            ratingsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            ratingsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            submitButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            submitButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func addRatingBarRow(to stackView: UIStackView, label: String, barWidthMultiplier: CGFloat) {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = 8
        rowStackView.alignment = .center
        
        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textLabel.textColor = .black
        textLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        rowStackView.addArrangedSubview(textLabel)
        
        let barContainerView = UIView()
        barContainerView.translatesAutoresizingMaskIntoConstraints = false
        let barView = UIView()
        barView.backgroundColor = UIColor(hex: "005C78")
        barView.translatesAutoresizingMaskIntoConstraints = false
        barContainerView.addSubview(barView)
        
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: barContainerView.leadingAnchor),
            barView.topAnchor.constraint(equalTo: barContainerView.topAnchor),
            barView.bottomAnchor.constraint(equalTo: barContainerView.bottomAnchor),
            barView.widthAnchor.constraint(equalTo: barContainerView.widthAnchor, multiplier: barWidthMultiplier)
        ])
        
        rowStackView.addArrangedSubview(barContainerView)
        stackView.addArrangedSubview(rowStackView)
        
        NSLayoutConstraint.activate([
            barView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc private func starTapped(_ sender: UIButton) {
        selectedRating = sender.tag
        for case let starButton as UIButton in starsStackView.arrangedSubviews {
            let imageName = starButton.tag <= selectedRating ? "star.fill" : "star"
            starButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @objc private func closeTapped() {
        removeFromSuperview()
    }
    
    @objc private func submitTapped() {
        completion?(selectedRating)
        removeFromSuperview()
    }
}
