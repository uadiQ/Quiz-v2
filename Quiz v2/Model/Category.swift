//
//  Category.swift
//  Quiz v2
//
//  Created by Vadim Shoshin on 01.12.2017.
//  Copyright © 2017 Vadim Shoshin. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Category {
    let name: String
    let id: Int
}

extension Category {
    init?(json: JSON) {
        guard let id = json["id"].int, let name = json["name"].string else { return nil }
        
        self.id = id
        self.name = name
    }
}
