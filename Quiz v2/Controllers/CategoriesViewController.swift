//
//  CategoriesViewController.swift
//  Quiz v2
//
//  Created by Vadim Shoshin on 01.12.2017.
//  Copyright © 2017 Vadim Shoshin. All rights reserved.
//

import UIKit
import PKHUD

class CategoriesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableSetting()
        DataManager.instance.loadCategories()
        HUD.show(.progress)
    }
    
    private func setupTableSetting() {
        tableView.dataSource = self
        tableView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(categoriesLoaded), name: .CategoriesLoaded, object: nil)
    }
    
    private func getCategory(for indexPath: IndexPath) -> Category {
        let categoryToLoad = DataManager.instance.categoriesArray[indexPath.row]
        return categoryToLoad
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showQuestionsList", let destVC = segue.destination as? QuestionsListViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        destVC.category = getCategory(for: indexPath)
    }
    
}

// MARK: - TableView extensions

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellID, for: indexPath) as? CategoryTableViewCell else { fatalError("Cell with wrong identifier") }
        
        let category = getCategory(for: indexPath)
        cell.update(category)
        return cell
    }
}

// MARK: - Notification extension

extension CategoriesViewController {
    @objc func categoriesLoaded() {
        HUD.hide()
        tableView.reloadData()
    }
}
