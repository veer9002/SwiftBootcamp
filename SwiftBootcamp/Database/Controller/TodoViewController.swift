//
//  TodoViewController.swift
//  SwiftBootcamp
//
//  Created by Syon on 28/02/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {

    var array = [TodoList]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = TodoList()
        data.title = "One"
        data.isCheck = true
        array.append(data)
        
        let data1 = TodoList()
        data1.title = "two"
        array.append(data1)
       
        let data2 = TodoList()
        data2.title = "three"
        array.append(data2)
        
    }
    
    // MARK: Add new item
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new item", style: .default) { (alertAction) in
           
            let newItem = TodoList()
            newItem.title = textfield.text!

            self.array.append(newItem)
            self.defaults.set(self.array, forKey: "TodoList")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (todoTextField) in
            todoTextField.placeholder = "Create new task"
            textfield = todoTextField
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = array[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.isCheck ? .checkmark : .none
    
//        if item.isCheck == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    

    // Delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        array[indexPath.row].isCheck = !array[indexPath.row].isCheck
        self.tableView.reloadData()
    }
    

}
