//
//  QuestionDetailsViewController.swift
//  Quiz v2
//
//  Created by Vadim Shoshin on 02.12.2017.
//  Copyright © 2017 Vadim Shoshin. All rights reserved.
//

import UIKit

class QuestionDetailsViewController: UIViewController {
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private var answerButtons: [UIButton]!
    
    var questionToLoad: Question?
    var pageTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        guard let pageQuestion = questionToLoad else { return }
        guard let questionCategory = pageTitle else { return }
        
        title = questionCategory
        questionLabel.text = pageQuestion.question
        
        for i in 0..<answerButtons.count {
            answerButtons[i].setTitle(pageQuestion.optionsArray[i], for: .normal)
        }
    }
    
    private func gratz() {
        let gratzAlert = UIAlertController(title: "Great!", message: "That's Right!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        gratzAlert.addAction(okAction)
        self.present(gratzAlert, animated: true, completion: nil)
    }
    
    private func tryAgain() {
        let tryAgainAlert = UIAlertController(title: "Oops", message: "Wrong answer, try again!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        tryAgainAlert.addAction(okAction)
        self.present(tryAgainAlert, animated: true, completion: nil)
    }
    
    @IBAction func anyAnswerButtonPressed(_ sender: UIButton) {
        guard let pageQuestion = questionToLoad else { return }
        let answer = pageQuestion.answer
        
        if sender.tag == answer {
            gratz()
        } else {
            tryAgain()
        }
    }
}
