//
//  ViewController.swift
//  ToDoApp
//
//  Created by Ged Guillaume on 7/5/18.
//  Copyright © 2018 Ged Guillaume. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    var itemArray = [item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = item()
        newItem.title = "Learn iOS Development"
        itemArray.append(newItem)
        
        let newItem2 = item()
        newItem2.title = "Go to the Gym"
        itemArray.append(newItem2)
        
        let newItem3 = item()
        newItem3.title = "Get this Money!!"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [item] {
            itemArray = items
        }
    }


    
    //MARK - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        //unhighlights row for UI
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            //what will happen once the user clicks the Add Item Button on our UIAlert
            //append itemArray to add new ToDo
            
            let newItem = item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new ToDo"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

