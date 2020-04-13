//
//  NewTaskVC.swift
//  Asistante
//
//  Created by Domenico Allegra on 04/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class NewTaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, NewTaskDelegate {
    
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
            taskDetailInt = 2
        }
        else if taskTypeDetail == "Moderate" {
            taskDetailInt = 1
            
        }
        else if taskTypeDetail == "Important" {
            taskDetailInt = 0
            
        }
        else {
            taskDetailInt = 3
        }
        
        print("Contents of priority: \(taskTypeDetail)")
        tableView.reloadData()
    }
    
    var dueDate = Date()
    var taskDelegate: TasksTVCDelegate?
    
    var taskTypeDetail:String = "Low"
    var taskDetailInt:Int = 0
    var taskReminderDate = Date()
    
    let cellContents: [String] = ["Due Date", "Set Reminder", "Invite Friends", "Set Priority"]
    
    
    
//    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
//        tableView.reloadData()
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addTaskCell", for: indexPath)
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
            cell.detailTextLabel?.text = cellLabel
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
            performSegue(withIdentifier: "dueDateSegue", sender: self)
        }
        else if indexPath.row == 1 {
            performSegue(withIdentifier: "addReminderSegue", sender: self)
        }
        else if indexPath.row == 2 {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM HH:mm"
            let datePost = dateFormatter.string(from: taskReminderDate)
                                  
            let msg = "Hi buddy! I need your help to remind me to do this task! I have a \(taskTitleTextField.text!) and it should be done on \(datePost). This task is very important for me. So, please help me! Thank you🤗"
            let urlWhats = "whatsapp://send?text=\(msg)"

            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
            if UIApplication.shared.canOpenURL(whatsappURL as URL) {
            UIApplication.shared.openURL(whatsappURL as URL)
             } else {
             print("please install WhatsApp!")
            }
        }
    }
 }
        else if indexPath.row == 3 {
            performSegue(withIdentifier: "setPrioritySegue", sender: self)
        }
    }
    
    
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
//
//  Notification properties
    
    let userNotificationCenter = UNUserNotificationCenter.current()
        
        func requestNotificationAuthorization() {
            
            let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
            self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
                if let error = error {
                    print("Error: ", error)
                }
            }
            // Code here
        }

        func sendNotification(title: String, body: String, value:Int, dateCasted: Date) {
            
            let notificationContent = UNMutableNotificationContent()

            // Add the content to the notification content
            notificationContent.title = "Hello, you asked me to remind you.."
            notificationContent.body = "Task '\(title)'"
            notificationContent.badge = NSNumber(value: value)
            notificationContent.sound = .default
            //notificationContent.userInfo

            // Add an attachment to the notification content
            if let url = Bundle.main.url(forResource: "dune",
                                            withExtension: "png") {
                if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                                    url: url,
                                                                    options: nil) {
                    notificationContent.attachments = [attachment]
                }
            }
            
            var dateComponents = DateComponents()
            
            let formatterY = DateFormatter()
            formatterY.dateFormat = "yyyy"
            let insertedY = formatterY.string(from: dateCasted)
            dateComponents.year = Int(insertedY)
            
            let formatterMM = DateFormatter()
            formatterMM.dateFormat = "MM"
            let insertedMM = formatterMM.string(from: dateCasted)
            dateComponents.month = Int(insertedMM)
            
            let formatterD = DateFormatter()
            formatterD.dateFormat = "dd"
            let insertedD = formatterD.string(from: dateCasted)
            dateComponents.day = Int(insertedD)

            
            let formatterH = DateFormatter()
            formatterH.dateFormat = "HH"
            let insertedH = formatterH.string(from: dateCasted)
            dateComponents.hour = Int(insertedH)
            
            let formatterM = DateFormatter()
            formatterM.dateFormat = "mm"
            let insertedM = formatterM.string(from: dateCasted)
            dateComponents.minute = Int(insertedM)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
    //        repeats: false)
            
            let request = UNNotificationRequest(identifier: "testNotification",
            content: notificationContent,
            trigger: trigger)
            
            userNotificationCenter.add(request) { (error) in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
            
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            completionHandler()
        }

        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .badge, .sound])
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDelegate = TasksTVC()
        tableView.delegate = self

        descriptionTextView.text = "Task description"
        descriptionTextView.textColor = .lightGray
        descriptionTextView.delegate = self

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Task description"
            textView.textColor = UIColor.lightGray
        }
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
        if let destinationReminder = segue.destination as? AddReminderVC {
            destinationReminder.newTaskDelegate = self
        }
        if let destinationDueDate = segue.destination as? AddDueDateVC {
            destinationDueDate.newTaskDelegate = self
        }
        if let destinationPriority = segue.destination as? TaskPriorityVC {
            destinationPriority.newTaskDelegate = self
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
        
         if taskTitleTextField.text != "" {
            
            guard let nameToSave = taskTitleTextField.text else {return}
            guard let descriptionToSave = descriptionTextView.text else {return}
            let dateToSave = dueDate
            let priorityToSave = taskDetailInt
            taskDelegate?.didSaveNew(name: nameToSave, description: descriptionToSave, date: dateToSave, state: priorityToSave)
            sendNotification(title: nameToSave, body: descriptionToSave, value: 1, dateCasted: self.taskReminderDate)
            tabBarController?.selectedIndex = 0
            //taskDelegate?.didUpdateTableView(sender: self)

            
        }
                
            else {
            
                        let alert = UIAlertController(title: "Error", message: "Task title cannot be empty.", preferredStyle: .alert)
                            
                            
                            let backToAddTaskAction = UIAlertAction(title: "OK", style: .cancel)
                            alert.addAction(backToAddTaskAction)
                            present(alert, animated: true)
                        }
                    
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


