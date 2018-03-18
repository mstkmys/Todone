//
//  TodoListViewController.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/15.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController {
    
    let todoListView: TodoListView = {
       
        let todoListView = TodoListView(frame: UIScreen.main.bounds)
        todoListView.backgroundColor = .white
        
        return todoListView
        
    }()
    
    // MARK: - Properties
    
    let realm = try! Realm()
    var todoItems: Results<Item>?
    
    var selectedCategory: Category? {
        didSet {
            loadImtes()
        }
    }
    var navigationTitle: String? = "TODO"
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        
        // Add views
        [todoListView].forEach{ self.view.addSubview($0) }
        
        // Datasouce, Delegate
        todoListView.searchBar.delegate = self
        todoListView.todoListTableView.dataSource = self
        todoListView.todoListTableView.delegate = self
        
    }
    
    // MARK: - Methods
    
    private func setUpNavigation() {
        
        self.navigationItem.title = navigationTitle
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = addBarButton
        
    }
    
    private func updateUI() {
        todoListView.todoListTableView.reloadData()
    }
    
    // MARK: - Data Manipulation
    
    private func loadImtes() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        updateUI()

    }
    
    // MARK: - Actions
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TODO", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        
                        newItem.created = Date()
                        currentCategory.items.append(newItem)
                    }
                }
                catch {
                    print("Error saving item: \(error)")
                }
                self.updateUI()
                
            }

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
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "created", ascending: true)
        updateUI()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadImtes()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
        
    }
    
}

// MARK: - UITableViewDataSource
/***************************************************************************************************************/
extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Cell row height
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell?
        
        if cell == nil {
            // Create cell
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: NSStringFromClass(TodoListTableViewCell.self))
        }
        
        if let item = todoItems?[indexPath.row] {
            // Set text for indexPath
            cell?.textLabel?.text = item.title
            // Set detail text
            if let createDate = item.created {
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = DateFormatter.dateFormat(
                    fromTemplate: "ydMMM",
                    options: 0,
                    locale: Locale(identifier: "js_JP")
                )
                cell?.detailTextLabel?.text = dateformatter.string(from: createDate)
            }
            // Set checkmark if done Property is true
            cell?.accessoryType = item.done ? .checkmark : .none
        }
        else {
            cell?.textLabel?.text = "No Items"
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

// MARK: - UITableViewDelegate
/***************************************************************************************************************/
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            
            do {
                try realm.write {
                    item.done = !item.done
                }
            }
            catch {
                print("Error saving done: \(error)")
            }
            
        }
        updateUI()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if let item = todoItems?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                }
                catch {
                    print("Error deleting category: \(error)")
                }
                
                updateUI()
            }
        }
        
    }

    
}
















