//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Nuri Chun on 8/27/19.
//  Copyright © 2019 tetra. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Buy Eggs"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Buy Milk"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Buy Cereal"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy Steak"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Buy Chicken"
        itemArray.append(newItem4)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    // MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            let newItem = Item()
            guard var text = textField.text else { return }
            
            if text != "" {
                newItem.title = text
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
            } else {
                text = "Empty Title"
                newItem.title = text
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
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
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isChecked ? .checkmark : .none
        
        return cell
    }
    
    // MARK: - TABLEVIEW Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].isChecked = !itemArray[indexPath.row].isChecked
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
