//
//  TodoViewController.swift
//  SwiftBootcamp
//
//  Created by Syon on 28/02/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var array = [TodoList]()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        print("Data file path ::: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
//        loadItems()
    }
    
    // MARK: Add new item
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new item", style: .default) { (alertAction) in
           
            let newItem = TodoList(context: self.context)
            newItem.title = textfield.text!
            newItem.isChecked = false
            newItem.parentCategory = self.selectedCategory
            self.array.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (todoTextField) in
            todoTextField.placeholder = "Create new task"
            textfield = todoTextField
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // Data from Items.plist
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.array)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error in storing in plist")
        }
        self.tableView.reloadData()
    }
 */
    
    func saveItems() {
        
        do {
          try context.save()
        } catch {
            print("Error in \(error)")
        }
        self.tableView.reloadData()
    }
    
    // from plist
//    func loadItems() {
//
//        if let data = try? Data(contentsOf: self.dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                array = try decoder.decode([TodoList].self, from: data)
//            } catch {
//                print("Error::: \(error)")
//            }
//        }
//    }
    
    // from core data
    func loadItems(with request: NSFetchRequest<TodoList> = TodoList.fetchRequest()) {
        
        do {
          array = try context.fetch(request)
        } catch {
            print("Error in fetching: \(error)")
        }
        self.tableView.reloadData()
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
        
        cell.accessoryType = item.isChecked ? .checkmark : .none
    
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
        
        // delete from core data
//        context.delete(array[indexPath.row])
//        self.array.remove(at: indexPath.row)
        
        // update in core data
//        self.array[indexPath.row].setValue("Completed", forKey: "title")
        
        array[indexPath.row].isChecked = !array[indexPath.row].isChecked
        saveItems()
    }

}

extension TodoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS %@", self.searchBar.text!)
        
        let sortedDescr = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortedDescr]
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                self.searchBar.resignFirstResponder()
            }
        }
    }
}
