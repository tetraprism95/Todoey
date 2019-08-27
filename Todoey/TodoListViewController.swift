//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Nuri Chun on 8/27/19.
//  Copyright © 2019 tetra. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Buy eggs", "Buy Milk", "Buy Oreos"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
