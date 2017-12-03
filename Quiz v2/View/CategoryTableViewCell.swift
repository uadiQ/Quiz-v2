//
//  CategoryTableViewCell.swift
//  Quiz v2
//
//  Created by Vadim Shoshin on 01.12.2017.
//  Copyright © 2017 Vadim Shoshin. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var categoryNameLabel: UILabel!
    
    static let cellID = "CategoryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(_ category: Category) {
        categoryNameLabel.text = category.name
    }

}
