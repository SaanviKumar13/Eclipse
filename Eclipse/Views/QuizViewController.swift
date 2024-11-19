//
//  QuizViewController.swift
//  Eclipse
//
//  Created by user@87 on 15/11/24.
//

import UIKit

class QuizViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var quiz: Quiz!
    var currentQuestionIndex = 0
    var selectedOptions: [Int: Set<String>] = [:]
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quiz = sampleQuiz
        setupUI()
        configureCollectionView()
        loadQuestion()
    }
    
    private func setupUI() {
        questionLabel.numberOfLines = 0
        questionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        questionLabel.textAlignment = .center
        
        nextButton.backgroundColor = UIColor(hex: "005C78")
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        nextButton.layer.cornerRadius = 12
        
        view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private func configureCollectionView() {
        optionsCollectionView.backgroundColor = .clear
        
        if let flowLayout = optionsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 12
            flowLayout.minimumInteritemSpacing = 12
            flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            flowLayout.scrollDirection = .vertical
        }
        
        optionsCollectionView.allowsMultipleSelection = true
        optionsCollectionView.delegate = self
        optionsCollectionView.dataSource = self
    }
    
    private func loadQuestion() {
        guard currentQuestionIndex < quiz.questions.count else {
            showResults()
            return
        }
        
        let currentQuestion = quiz.questions[currentQuestionIndex]
        questionLabel.text = currentQuestion.questionText
        
        progressView.progress = Float(currentQuestionIndex + 1) / Float(quiz.questions.count)
        
        updateNextButtonState()
        
        let isLastQuestion = currentQuestionIndex == quiz.questions.count - 1
        nextButton.setTitle(isLastQuestion ? "Submit" : "Next", for: .normal)
        
        optionsCollectionView.reloadData()
    }
    
    private func updateNextButtonState() {
        let currentQuestion = quiz.questions[currentQuestionIndex]
        let selectedCount = selectedOptions[currentQuestion.id]?.count ?? 0
        nextButton.isEnabled = selectedCount > 0
    }
    
    private func showResults() {
        print(selectedOptions)
        performSegue(withIdentifier: "showResults", sender: self)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentQuestionIndex == quiz.questions.count - 1 {
            showResults()
        } else {
            currentQuestionIndex += 1
            loadQuestion()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quiz.questions[currentQuestionIndex].options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as? QuizOptionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let currentQuestion = quiz.questions[currentQuestionIndex]
        let option = currentQuestion.options[indexPath.item]
        let isSelected = selectedOptions[currentQuestion.id]?.contains(option) ?? false
        
        cell.configure(option: option, isSelected: isSelected)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleOptionSelection(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        handleOptionSelection(at: indexPath)
    }
    
    private func handleOptionSelection(at indexPath: IndexPath) {
        let currentQuestion = quiz.questions[currentQuestionIndex]
        let option = currentQuestion.options[indexPath.item]
        
        var selected = selectedOptions[currentQuestion.id] ?? Set<String>()
        
        if selected.contains(option) {
            selected.remove(option)
        } else {
            if !currentQuestion.isMultipleChoice {
                selected.removeAll()
            }
            selected.insert(option)
        }
        
        selectedOptions[currentQuestion.id] = selected
        updateNextButtonState()
        optionsCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 32
        let itemWidth = availableWidth
        let itemHeight: CGFloat = 56
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
