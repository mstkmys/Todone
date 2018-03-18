//
//  TodoListView.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/15.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import Chameleon

class TodoListView: UIView {
    
    // MARK: - Properties
    
    let searchBar: UISearchBar = {
       
        let searchBar = UISearchBar()
        searchBar.barTintColor = .flatSkyBlue()
        
        return searchBar
        
    }()
    
    let todoListTableView: UITableView = {
       
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TodoListTableViewCell.self))
        
        return tableView
        
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add Views
        [searchBar,todoListTableView].forEach{ self.addSubview($0) }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        
        searchBar.anchor(
            top: self.safeAreaLayoutGuide.topAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            size: .init(width: 0, height: 64)
        )
        
        todoListTableView.anchor(
            top: searchBar.bottomAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor
        )
        
    }

}
















