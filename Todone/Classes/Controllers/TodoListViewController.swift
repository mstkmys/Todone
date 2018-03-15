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
    
    // MARK: - Properties
    
    var itemArray = ["Find Money", "Finish Homework", "Play Game"]
    let defaults = UserDefaults.standard
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        
        // Add Views
        [todoListView].forEach{ self.view.addSubview($0) }
        
        // Datasouce, Delegate
        todoListView.todoListTableView.dataSource = self
        todoListView.todoListTableView.delegate = self
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        
    }
    
    // MARK: - Methods
    
    private func setUpNavigation() {
        
        self.navigationItem.title = "TODO"
        self.navigationController?.navigationBar.barTintColor = .nigelle()
        self.navigationController?.navigationBar.tintColor = .white
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = addBarButton
        
    }
    
    private func updateUI() {
        self.todoListView.todoListTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TODO", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.updateUI()
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add New TODO"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }

}

// MARK: - UITableViewDataSource
/***************************************************************************************************************/
extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Cell Row Height
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell?
        
        if cell == nil {
            // Create Cell
            cell = UITableViewCell(style: .value1, reuseIdentifier: NSStringFromClass(TodoListTableViewCell.self))
        }
        
        // Set Text For IndexPath
        cell?.textLabel?.text = itemArray[indexPath.row]
        
        return cell!
        
    }
    
}

// MARK: - UITableViewDelegate
/***************************************************************************************************************/
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
















