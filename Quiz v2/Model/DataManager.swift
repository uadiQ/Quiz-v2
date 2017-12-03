//
//  DataManager.swift
//  Quiz v2
//
//  Created by Vadim Shoshin on 01.12.2017.
//  Copyright © 2017 Vadim Shoshin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

final class DataManager {
    static let instance = DataManager()
    private init() {}
    
    private(set) var categoriesArray: [Category] = []
    private(set) var questionsForCategories: [Int: [Question]] = [:]
    
    func loadCategories() {
        Alamofire.request("https://qriusity.com/v1/categories/").responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonObj = JSON(value)
                guard let jsonArray = jsonObj.array else { return }
                for jsonObject in jsonArray {
                    guard let category = Category(json: jsonObject) else { continue }
                    self.categoriesArray.append(category)
                }
                NotificationCenter.default.post(name: .CategoriesLoaded, object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadQuestions(for category: Category) {
        let id = category.id
        Alamofire.request("https://qriusity.com/v1/categories/\(id)/questions").responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonObj = JSON(value)
                guard let jsonArray = jsonObj.array else { return }
                for jsonObject in jsonArray {
                    guard let question = Question(json: jsonObject) else { continue }
                    var tempQuestionsArray = self.questionsForCategories[id] ?? []
                    tempQuestionsArray.append(question)
                    self.questionsForCategories[id] = tempQuestionsArray
                }
                NotificationCenter.default.post(name: .QuestionsLoaded, object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

    func questions(of category: Category) -> [Question] {
        return questionsForCategories[category.id] ?? []
    }
    
}
