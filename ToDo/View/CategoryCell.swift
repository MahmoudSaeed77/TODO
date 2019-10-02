//
//  CategoryCell.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 10/2/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit


class CategoryCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellId")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
