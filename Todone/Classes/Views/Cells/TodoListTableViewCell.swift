//
//  TodoListTableViewCell.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/15.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    // MARK: - Properties

//    let label: UILabel = {
//
//        let label = UILabel()
//
//        return label
//
//    }()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add Views
//        [].forEach{ self.addSubview($0) }
        
        self.textLabel?.text = "AAAA"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        
//        label.anchor(
//            top: self.topAnchor,
//            leading: self.leadingAnchor,
//            bottom: self.bottomAnchor,
//            trailing: nil,
//            padding: .init(top: 10, left: 10, bottom: 0, right: 10)
//        )
        
    }

}
























