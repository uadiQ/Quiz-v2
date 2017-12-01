//  Question.swift
//  Quiz v2
//
//  Created by Vadim Shoshin on 01.12.2017.
//  Copyright © 2017 Vadim Shoshin. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Question {
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let id: Int
    let answer: Int
    var optionsArray: [String] = []
}

extension Question {
    init?(json: JSON) {
        guard let id = json["id"].int, let question = json["question"].string else { return nil}
        
        self.id = id
        self.question = question
        self.option1 = json["option1"].stringValue
        self.option2 = json["option2"].stringValue
        self.option3 = json["option3"].stringValue
        self.option4 = json["option4"].stringValue
        self.answer = json["answers"].intValue - 1
        optionsArray = [option1, option2, option3, option4]
    }
}
