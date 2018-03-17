//
//  Category.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/18.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}




















