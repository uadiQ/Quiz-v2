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
    
    var categoriesArray: [Category] = []
    var questionsForCategories: [Int: Question] = [:]
    
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
                print(self.categoriesArray)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCategory(indexPath: IndexPath) -> Category? {
        return categoriesArray[indexPath.row]
    }
}
