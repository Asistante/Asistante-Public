//
//  NewTaskVC.swift
//  Asistante
//
//  Created by Domenico Allegra on 04/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

protocol TasksTVCDelegate {
    func didSaved(name: String, description: String, date: Date, state: Int)
    func didSaveNew(name: String, description: String, date: Date, state: Int)
}

class NewTaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var taskDelegate: TasksTVCDelegate?
    
    var taskTypeDetail:String = ""
    
    let cellContents: [String] = ["Due Date", "Set Reminder", "Invite Friends", "Set Priority"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addTaskCell", for: indexPath)
        cell.textLabel?.text = cellContents[indexPath.row]
        if indexPath.row == 1 {cell.detailTextLabel?.text = dateshown}
        else if indexPath.row == 3 {cell.detailTextLabel?.text = taskTypeDetail}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {}
        else if indexPath.row == 1 {
            performSegue(withIdentifier: "addReminderSegue", sender: self)
        }
        else if indexPath.row == 3 {
            performSegue(withIdentifier: "setPrioritySegue", sender: self)
        }
    }
    
    
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addTaskButton: UIButton!
    
//
//    struct TasksDataModel {
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //title = "Add Task"
        //taskTypeDetail = taskType

//        self.taskStatePicker.delegate = self
//        self.taskStatePicker.dataSource = self
        //tabBarController?.tabBar.isHidden = true
        
//        addTaskButton.layer.cornerRadius = 25
        
        if descriptionTextView.text == "" {
            descriptionTextView.text = "Description"
            descriptionTextView.textColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.7764705882, alpha: 1)
        }
        else {
            return
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //Blur effect for alert view. Set parameter true to show, false to dismiss.
    func blurEffect(state:Bool){
        //view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurVisualEffectView.frame = view.bounds
        //blurVisualEffectView.isDescendant(of: view)
        
        if state == true {
            
            self.view.addSubview(blurVisualEffectView)
        }
        else {
            
            let removedSubview = view.subviews.last
            print ("Removing: \(String(describing: view.subviews.last)) from superview.")
            DispatchQueue.main.async {
                removedSubview?.removeFromSuperview()
            }
            
//             UIView.animate(withDuration: 0.95, delay: 0, options: .curveEaseIn, animations:  {() -> Void in
//
//
//            //            blurVisualEffectView.effect = nil
//                        }, completion: {(finished:Bool) -> Void in
//                        })
                        
        }
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        //blurEffect(state: true)
        
        let alert = UIAlertController(title: "Cancel Add Task", message: "Are you sure? Unsaved changes will be lost.", preferredStyle: .alert)
        
        
        let backToAddTaskAction = UIAlertAction(title: "Cancel", style: .cancel){
            [unowned self] action in
            self.blurEffect(state: false)
            print ("Dismissing alert.")
            
        }
        
        
        let dismissAction = UIAlertAction(title: "Discard", style: .destructive){
            [unowned self] action in
            print ("Dismissing alert.")
            self.blurEffect(state: false)
            self.dismiss(animated: true, completion: nil)
            
        }
        
        alert.addAction(dismissAction)
        alert.addAction(backToAddTaskAction)
        
        blurEffect(state: true)
        print ("Present blur effect.")
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TasksTVC {
            
        }
    }
    
//    @IBAction func saveButtonPressed(_ unwindSegue: UIStoryboardSegue, sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "unwindToTabBar", sender: self)
//        dismiss(animated: true, completion: nil)
//    }
        
    
    //PickerView Setup.
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return tasksPicker.count
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return tasksPicker[row]
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let chosenState = row
//        print (chosenState)
//    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
         if taskTitleTextField.text == "" {
        //        let nameToSave = taskTitleTextField.text
        //        let descriptionToSave = descriptionTextView.text
        //        let dateToSave = ""
                
                tabBarController?.selectedIndex = 0
                    
                }
                
                else {
                    
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
