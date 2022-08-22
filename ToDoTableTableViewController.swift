//
//  ToDoTableTableViewController.swift
//  To Do List
//
//  Created by Kaajal  on 8/15/22.
//

import UIKit

class ToDoTableTableViewController: UITableViewController {

    
    var toDos : [ToDoCD] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    func getToDos()
    {
    //go into core data and get all of the to dos
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                toDos = coreDataToDos
                tableView.reloadData()
                
                }
            // try to go get those objects stored in CD
            
        }
    
    }
   

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let toDo = toDos[indexPath.row]
        
        //if task is important
        
        if let name = toDo.name {
        if toDo.important {
            cell.textLabel?.text = "❗️ " + name
        }
        else {
            cell.textLabel?.text = "" + name
        }
        }

        return cell
    }
    

    

    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // a single ToDo
        
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController
        {
            //setting up reference to be sent to other view controller
            addVC.previousVC = self
        }
        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
    }
   

}
