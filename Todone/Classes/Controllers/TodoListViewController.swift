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
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        
        // Add views
        [todoListView].forEach{ self.view.addSubview($0) }
        
        // Datasouce, Delegate
        todoListView.todoListTableView.dataSource = self
        todoListView.todoListTableView.delegate = self
        
        let newItem = Item()
        newItem.title = "Find Milk"
        
        let newItem2 = Item()
        newItem2.title = "Go Work"
        
        let newItem3 = Item()
        newItem3.title = "Play Game"
        
        [newItem, newItem2, newItem3].forEach{ itemArray.append($0) }
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
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
        todoListView.todoListTableView.reloadData()
    }
    
    private func saveItems() {
        
        let encoder = PropertyListEncoder()
        // Throws
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            print("Error encoding item array [\(error)]")
        }
        
        updateUI()
        
    }
    
    // MARK: - Actions
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TODO", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)

            // Save into Userdefaults
            self.saveItems()
            
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
        // Cell row height
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell?
        
        if cell == nil {
            // Create cell
            cell = UITableViewCell(style: .value1, reuseIdentifier: NSStringFromClass(TodoListTableViewCell.self))
        }
        
        let item = itemArray[indexPath.row]
        
        // Set text for indexPath
        cell?.textLabel?.text = item.title
        
        // Set checkmark if done Property is true
        cell?.accessoryType = item.done ? .checkmark : .none
        
        return cell!
        
    }
    
}

// MARK: - UITableViewDelegate
/***************************************************************************************************************/
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // Save into Userdefaults
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
















