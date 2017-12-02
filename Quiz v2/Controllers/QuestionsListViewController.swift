//
//  QuestionsListViewController.swift
//  Quiz v2
//
//  Created by Vadim Shoshin on 01.12.2017.
//  Copyright © 2017 Vadim Shoshin. All rights reserved.
//
import UIKit

class QuestionsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var category: Category?
    var questionsArray: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(questionsLoaded), name: .QuestionsLoaded, object: nil)
        
        guard let parentCategory = category else { return }
        title = parentCategory.name
        
        questionsArray = DataManager.instance.questions(of: parentCategory)
        if questionsArray.isEmpty {
            DataManager.instance.loadQuestions(for: parentCategory)
        }
    }
    
    private func getQuestion(indexPath: IndexPath) -> Question {
        return questionsArray[indexPath.row]
    }
}

// MARK: - TableView extensions
extension QuestionsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as? QuestionTableViewCell else { fatalError("Cell with wrong identifier") }
        
        let question = getQuestion(indexPath: indexPath)
        cell.update(question)
        return cell
    }
}

// MARK: - Notification extension
extension QuestionsListViewController {
    @objc func questionsLoaded() {
        guard let categoryToLoad = category else { return }
        questionsArray = DataManager.instance.questions(of: categoryToLoad)
        tableView.reloadData()
    }
}
