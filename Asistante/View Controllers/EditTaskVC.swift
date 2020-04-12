//
//  EditTaskVC.swift
//  Asistante
//
//  Created by Domenico Allegra on 06/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class EditTaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource, EditTaskDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
    var textFieldContent:String = ""
    var textViewContent:String = ""
    var taskDelegate: TasksTVCDelegate?
    var currentIndexFromTasks:Int = 0
    var dueDate = Date()
    var taskTypeDetail:String = "Low"
    var taskDetailInt:Int = 0
    var taskReminderDate = Date()
    
    let cellContents: [String] = ["Due Date", "Set Reminder", "Invite Friends", "Set Priority"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        super.viewWillAppear(animated)
        textField.text = textFieldContent
        textView.text = textViewContent
        
        if taskDetailInt == 0 {
            taskTypeDetail = "Low"
        }
        else if taskDetailInt == 1 {
            taskTypeDetail = "Moderate"
        }
        else if taskDetailInt == 2 {
            taskTypeDetail = "Important"
        }
        else {
            taskTypeDetail = "Assisted"
        }
    }
    
    func passDate(date: Date) {
           dueDate = date
           tableView.reloadData()
       }
       
       func passReminder(date: Date){
           taskReminderDate = date
           print("Contents of TDR: \(taskReminderDate), received parameter date: \(date)")
           tableView.reloadData()
       }
       func passPriority(priority: String){
           taskTypeDetail = priority
           
           if taskTypeDetail == "Low" {
               taskDetailInt = 0
           }
           else if taskTypeDetail == "Moderate" {
               taskDetailInt = 1
               
           }
           else if taskTypeDetail == "Important" {
               taskDetailInt = 2
               
           }
           else {
               taskDetailInt = 3
           }
           
           print("Contents of priority: \(taskTypeDetail)")
           tableView.reloadData()
       }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editTaskCell", for: indexPath)
        cell.textLabel?.text = cellContents[indexPath.row]
        if indexPath.row == 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EE MMM d yyyy"
            let cellLabel = dateFormatter.string(from: dueDate)
            cell.detailTextLabel?.text = cellLabel
            cell.detailTextLabel?.textColor = .gray
            
        }
        else if indexPath.row == 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM HH:mm"
            let cellLabel = dateFormatter.string(from: taskReminderDate)
            cell.detailTextLabel?.text = "Coming Soon"//cellLabel
            cell.detailTextLabel?.textColor = .gray
        }
        else if indexPath.row == 3 {
            cell.detailTextLabel?.text = taskTypeDetail
            cell.detailTextLabel?.textColor = .gray
        }
        
        else {
            cell.detailTextLabel?.text = "Coming Soon"
            cell.detailTextLabel?.textColor = .gray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "addDueDateEditSegue", sender: self)
        }
        else if indexPath.row == 1 {
            //performSegue(withIdentifier: "addReminderEditSegue", sender: self)
        }
        else if indexPath.row == 3 {
            performSegue(withIdentifier: "setPriorityEditSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationReminder = segue.destination as? EditReminderVC {
            destinationReminder.editTaskDelegate = self
        }
        if let destinationDueDate = segue.destination as? EditDueDateVC {
            destinationDueDate.editTaskDelegate = self
        }
        if let destinationPriority = segue.destination as? EditPriorityVC {
            destinationPriority.editTaskDelegate = self
        }
    }
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        if textField.text != "" {

            guard let nameToSave = textField.text else {return}
            guard let descriptionToSave = textView.text else {return}
            let dateToSave = dueDate
            let priorityToSave = taskDetailInt
            taskDelegate?.didSaved(name: nameToSave, description: descriptionToSave, date: dateToSave, state: priorityToSave)
            self.navigationController?.popViewController(animated: true)
            //taskDelegate?.didUpdateTableView(sender: self)

        }
            else {

                        let alert = UIAlertController(title: "Error", message: "Task title cannot be empty.", preferredStyle: .alert)
                            let backToAddTaskAction = UIAlertAction(title: "OK", style: .cancel)
                            alert.addAction(backToAddTaskAction)
                            present(alert, animated: true)
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
