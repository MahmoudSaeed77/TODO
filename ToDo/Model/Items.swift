//
//  Items.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/30/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import Foundation
import RealmSwift

class Items: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated = Date()
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "item")
}
