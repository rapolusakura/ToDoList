//
//  ListTasksViewController.swift
//  ToDoList
//
//  Created by Sakura Rapolu on 7/6/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class ListTasksTableViewController: UITableViewController {
    
//    var tasks = [Task](){
//        didSet{
//            tableView.reloadData()
//        }
//    }
    
    var tasks: [Task] = [Task(taskText: "hello", isCompleted: true)]{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTaskCell", for: indexPath) as! ListTasksTableViewCell
        let task = tasks[indexPath.row]
        if task.isCompleted {
            cell.accessoryType = .checkmark
            print("i placed the check")
        }
        else {
            cell.accessoryType = .none
        }
        cell.taskLabel.text = task.taskText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    @IBAction func taskButtonPressed(_ sender: Any) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        var task = tasks[indexPath.row]
        task.isCompleted = true
        tableView.reloadData()
        print("\(indexPath)")
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "New Task", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "To do..."
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let taskDescription = alertController.textFields![0] as UITextField?
            let task = Task(taskText: (taskDescription?.text!)!, isCompleted: false)
            self.tasks.append(task)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
