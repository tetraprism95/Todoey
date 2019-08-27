//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Nuri Chun on 8/27/19.
//  Copyright © 2019 tetra. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Buy eggs", "Buy Milk", "Buy Oreos"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            guard var text = textField.text else { return }
            
            if text != "" {
                self.itemArray.append(text)
            } else {
                text = "Empty Title"
                self.itemArray.append(text)
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


extension TodoListViewController {
    
    // MARK: - TABLEVIEW Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // MARK: - TABLEVIEW Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType
        
        if accessoryType == .checkmark {
            accessoryType = .none
        } else {
            accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
