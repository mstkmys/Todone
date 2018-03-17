//
//  CategoryView.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/17.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit

class CategoryView: UIView {

    // MARK: - Properties
    
    let categoryTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(CategoryTableViewCell.self))
        
        return tableView
        
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add Views
        [categoryTableView].forEach{ self.addSubview($0) }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        
        categoryTableView.anchor(
            top: self.safeAreaLayoutGuide.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor
        )
        
    }

}
























