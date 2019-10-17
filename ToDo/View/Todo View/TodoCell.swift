//
//  CellClass.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/28/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import SwipeCellKit

class TodoCell: SwipeTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cellId")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
