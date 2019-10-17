//
//  Category.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/30/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework

//var colour: String = FlatRed().hexValue()

class Category: Object {
    @objc dynamic var name: String = ""
    let item = List<Items>()
}

class Colors: Object {
    @objc dynamic var color: String = FlatGray().hexValue()
}
