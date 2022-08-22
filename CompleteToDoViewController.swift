//
//  CompleteToDoViewController.swift
//  To Do List
//
//  Created by Kaajal  on 8/15/22.
//

import UIKit

class CompleteToDoViewController: UIViewController {

    var previousVC = ToDoTableTableViewController()
    var selectedToDo: ToDoCD?
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = selectedToDo?.name
    }
    
    @IBAction func completeTapped(_ sender: Any) {
        //when user taps on complete get into the core database
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        if let theToDo = selectedToDo {
            context.delete(theToDo) //delete a specific one
            //send back to table view 
            navigationController?.popViewController(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
