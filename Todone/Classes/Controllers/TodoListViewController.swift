//
//  TodoListViewController.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/15.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    
    let todoListView: TodoListView = {
       
        let todoListView = TodoListView(frame: UIScreen.main.bounds)
        todoListView.backgroundColor = .white
        
        return todoListView
        
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Views
        [todoListView].forEach{ self.view.addSubview($0) }
        
        // Datasouce, Delegate
        todoListView.todoListTableView.dataSource = self
        todoListView.todoListTableView.delegate = self
        
    }

}

// MARK: - UITableViewDataSource
/***************************************************************************************************************/
extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        return cell
        
    }
    
}

// MARK: - UITableViewDelegate
/***************************************************************************************************************/
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected cell [\(indexPath.row)]")
    }
    
}
















