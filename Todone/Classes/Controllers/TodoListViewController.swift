//
//  TodoListViewController.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/15.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UIViewController {
    
    let todoListView: TodoListView = {
       
        let todoListView = TodoListView(frame: UIScreen.main.bounds)
        todoListView.backgroundColor = .white
        
        return todoListView
        
    }()
    
    // MARK: - Properties
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        
        // Add views
        [todoListView].forEach{ self.view.addSubview($0) }
        
        // Datasouce, Delegate
        todoListView.todoListTableView.dataSource = self
        todoListView.todoListTableView.delegate = self
        
        loadImtes()
        
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
        
        // Throws
        do {
            try context.save()
        }
        catch {
            print("Error saving context: \(error)")
        }
        
        updateUI()
        
    }
    
    private func loadImtes() {

        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching context: \(error)")
        }

    }
    
    // MARK: - Actions
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TODO", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newItem = Item(context: self.context)
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
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // Save into Userdefaults
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
















