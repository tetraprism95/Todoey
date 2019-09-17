//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nuri Chun on 9/17/19.
//  Copyright © 2019 tetra. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext 

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alertController = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            let newCategory = Category(context: self.context)
            guard let text = textField.text else { return }
            
            if text != "" {
                newCategory.name = text
                self.categories.append(newCategory)
                self.saveCategory()
            } else {
                newCategory.name = "Default Category"
                self.categories.append(newCategory)
                self.saveCategory()
            }
        }
        
        alertController.addTextField { tf in
            tf.placeholder = "Enter Category Name"
            textField = tf
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error with saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItem(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print("Failed to fetch \(error)")
        }
    }
}

// MARK: - TableViewDataSource & TableViewDelegate Methods

extension CategoryViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
}
