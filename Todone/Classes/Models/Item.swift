//
//  Item.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/18.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var created: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}




















