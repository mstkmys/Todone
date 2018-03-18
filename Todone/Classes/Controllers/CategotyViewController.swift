//
//  CategotyViewController.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/17.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import RealmSwift

class CategotyViewController: UIViewController {

    let categoryView: CategoryView = {
        
        let categoryView = CategoryView(frame: UIScreen.main.bounds)
        categoryView.backgroundColor = .white
        
        return categoryView
        
    }()
    
    // MARK: - Properties
    
    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        
        // Add views
        [categoryView].forEach{ self.view.addSubview($0) }
        
        // Datasouce, Delegate
        categoryView.categoryTableView.dataSource = self
        categoryView.categoryTableView.delegate = self
        
        // loadItem
        loadCategories()
        
    }
    
    // MARK: - Methods
    
    private func setUpNavigation() {
        
        self.navigationItem.title = "Category"
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = addBarButton
        
    }
    
    private func updateUI() {
        categoryView.categoryTableView.reloadData()
    }
    
    // MARK: - Data Manipulation
    
    private func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving categories: \(error)")
        }
        updateUI()
        
    }
    
    private func loadCategories() {
        
        categoryArray = realm.objects(Category.self)
        
        updateUI()
        
    }
    
    // MARK: - Actions
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            // Save into Userdefaults
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Enter New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}


// MARK: - UITableViewDataSource
/***************************************************************************************************************/
extension CategotyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Cell row height
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?

        if cell == nil {
            // Create cell
            cell = UITableViewCell(style: .value1, reuseIdentifier: NSStringFromClass(CategoryTableViewCell.self))
        }
        
        // Set text for indexPath
        cell?.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Category"
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

// MARK: - UITableViewDelegate
/***************************************************************************************************************/
extension CategotyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let todoListVC = TodoListViewController()
        todoListVC.selectedCategory = categoryArray?[indexPath.row]
        todoListVC.navigationTitle = categoryArray?[indexPath.row].name
        self.navigationController?.pushViewController(todoListVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if let categoryForDeletion = categoryArray?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(categoryForDeletion)
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



















