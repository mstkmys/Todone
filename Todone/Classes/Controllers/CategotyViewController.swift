//
//  CategotyViewController.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/17.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import CoreData

class CategotyViewController: UIViewController {

    let categoryView: CategoryView = {
        
        let categoryView = CategoryView(frame: UIScreen.main.bounds)
        categoryView.backgroundColor = .white
        
        return categoryView
        
    }()
    
    // MARK: - Properties
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        self.navigationController?.navigationBar.barTintColor = .nigelle()
        self.navigationController?.navigationBar.tintColor = .white
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = addBarButton
        
    }
    
    private func updateUI() {
        categoryView.categoryTableView.reloadData()
    }
    
    // MARK: - Data Manipulation
    
    private func saveCategories() {
        
        do {
            try context.save()
        }
        catch {
            print("Error saving categories: \(error)")
        }
        updateUI()
        
    }
    
    private func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        }
        catch {
            print("Error fetching categories: \(error)")
        }
        updateUI()
        
    }
    
    // MARK: - Actions
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            // Save into Userdefaults
            self.saveCategories()
            
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
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Cell row height
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if cell == nil {
            // Create cell
            cell = UITableViewCell(style: .value1, reuseIdentifier: NSStringFromClass(CategoryTableViewCell.self))
        }
        
        // Set text for indexPath
        cell?.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell!
        
    }
    
}

// MARK: - UITableViewDelegate
/***************************************************************************************************************/
extension CategotyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let todoListVC = TodoListViewController()
        todoListVC.selectedCategory = categoryArray[indexPath.row]
        self.navigationController?.pushViewController(todoListVC, animated: true)
        
    }

}



















