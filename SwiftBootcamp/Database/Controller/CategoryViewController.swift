//
//  CategoryViewController.swift
//  SwiftBootcamp
//
//  Created by Manish Sharma on 09/03/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Data file path ::: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")

        loadItems()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    // MARK: Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "TodoViewController") as! TodoViewController
        destinationVC.selectedCategory = categoryArray[indexPath.row]
        self.show(destinationVC, sender: nil)
//        performSegue(withIdentifier: "goToItems", sender: self)
 
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! TodoViewController
//
//        if let indexPath = tableView.indexPathForSelectedRow {
//            destinationVC.selectedCategory = categoryArray[indexPath.row]
//            print(categoryArray[indexPath.row])
//        }
//    }
    
    //MARK: Button Actions
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new category", style: .default) { (alertAction) in
            
            let newItem = Category(context: self.context)
            newItem.name = textfield.text!
            self.categoryArray.append(newItem)
            
            self.saveCategoryItem()
        }
        
        alert.addTextField { (todoTextField) in
            todoTextField.placeholder = "Create new category"
            textfield = todoTextField
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Custom methods
    // from core data
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error in fetching: \(error)")
        }
        self.tableView.reloadData()
    }
    
    func saveCategoryItem() {
        do {
            try context.save()
        } catch {
            print("Error ::: \(error)")
        }
        self.tableView.reloadData()
    }
}
