//
//  Category.swift
//  Todoey
//
//  Created by Nuri Chun on 9/24/19.
//  Copyright © 2019 tetra. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
