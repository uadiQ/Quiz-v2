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
    }
}
