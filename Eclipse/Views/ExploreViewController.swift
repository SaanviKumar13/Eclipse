//
//  ExploreViewController.swift
//  Eclipse
//
//  Created by user@87 on 15/11/24.
//

import UIKit

class ExploreViewController: UIViewController {

    
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var quizText: UILabel!
    @IBOutlet weak var quizView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        quizText.numberOfLines = 0
        addGradientToView()
    }
    
    func addGradientToView(){
        quizView.layer.cornerRadius = 10
        quizView.clipsToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = quizView.bounds
        gradientLayer.colors = [
            UIColor(red: 0.0, green: 0.36, blue: 0.47, alpha: 1.0).cgColor,
            UIColor(red: 0.0, green: 0.36, blue: 0.47, alpha: 0.6).cgColor
                ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        quizView.layer.insertSublayer(gradientLayer, at: 0)
    }

}
