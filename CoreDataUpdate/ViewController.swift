//
//  ViewController.swift
//  CoreDataUpdate
//
//  Created by Khalida Aliyeva on 01.11.24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var list: [ToDoList] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var myTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchItems()
    }
    
    func fetchItems() {
        do {
            list = try context.fetch(ToDoList.fetchRequest())
            myTable.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveItem(text: String) {
        do {
            let model = ToDoList(context: context)
            model.title = text
            try context.save()
            fetchItems()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteItems(index: Int) {
        do {
            context.delete(list[index])
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateItems(updatedText: String, index: Int) {
        do {
            list[index].title = updatedText
            try context.save()
            fetchItems()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    
    
    func configureTableView() {
        myTable.delegate = self
        myTable.dataSource = self
        myTable.register(UINib(nibName: "Cell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        myTable.rowHeight = 50
    }
    
   
    
    @IBAction func addToList(_ sender: UIButton) {
        let alert = UIAlertController(title: "Enter New Item", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        
        let okAction = UIAlertAction(title: "ok", style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                self.saveItem(text: text)
                
            }
        }
        
        alert.addTextField { text in
            text.placeholder = "add new item"
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
        
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let object = list[indexPath.row]
        cell.myLabel.text = object.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.deleteItems(index: indexPath.row)
            self.list.remove(at: indexPath.row)
            self.myTable.reloadData()
            
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Update") { _, _, _ in
            
            let alert = UIAlertController(title: "Enter New Item", message: "", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addTextField { textField in
                textField.placeholder = "enter new item"
            }
            let okAction = UIAlertAction(title: "Update", style: .default) { _ in
                if let text = alert.textFields?.first?.text {
                    self.updateItems(updatedText: text, index: indexPath.row)
                }
                    
            }
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }
        
        let swipeAction = UISwipeActionsConfiguration(actions: [update])
        
        return swipeAction
    }
}

