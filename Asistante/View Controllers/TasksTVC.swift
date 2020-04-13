//
//  FirstViewController.swift
//  Asistante
//
//  Created by Domenico Allegra on 30/03/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

var managedContext:NSManagedObjectContext?


class TasksTVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate, TasksTVCDelegate {
    
    
    
    
    
    // Declare all IBOutlets here for UI elements.
        //Tasks table view declaration.
        @IBOutlet weak var tableView: UITableView!
    
        //Day buttons declaration.
        @IBOutlet weak var mondayButton: UIButton!
        @IBOutlet weak var tuesdayButton: UIButton!
        @IBOutlet weak var wednesdayButton: UIButton!
        @IBOutlet weak var thursdayButton: UIButton!
        @IBOutlet weak var fridayButton: UIButton!
        @IBOutlet weak var saturdayButton: UIButton!
        @IBOutlet weak var sundayButton: UIButton!
    
        //Placeholder label declaration.
        
        @IBOutlet weak var placeholderImage: UIImageView!
        @IBOutlet weak var placeholderText: UILabel!
    
        //Navigation bar buttons.
    @IBOutlet weak var notificationButton: UIBarButtonItem!
    
    
  
//Notification properties.
    
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
        notificationContent.title = title
        notificationContent.body = body
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
    
    
    
 //Tasks struct. Data is fetched from Core Data; will be called from appDelegate
    struct Tasks {
        var taskName:[NSManagedObject] = []
        var taskDescription:[NSManagedObject] = []
        var taskDate:[NSManagedObject] = []
        var taskState:[NSManagedObject] = []
        var taskIsActive:[NSManagedObject] = []
    }
    
    
    //Core Data save function.
    func didSaved(name: String, description: String, date: Date, state: Int) {
        print("\(tasks.taskName) and \(tasks.taskDescription) and \(tasks.taskDate) and \(tasks.taskState)")
        save(name: name, description: description, date: date, state: state)
    }
    
    func didSaveNew(name: String, description: String, date: Date, state: Int) {
        print("\(name) and \(description) and \(date) and \(state)")
        saveNew(name: name, description: description, date: date, state: state)
    }
    
    
    var tasks:Tasks = Tasks()
    var currentIndexBool:Int = 0
    var completedTaskCount:Int = 0
    var ongoingTaskCount:Int = 0
    
    
    //Declare cell types for table view.
    
    
//    enum CellType{
//        case activeTasksCell
//        case inactiveTasksCell
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        managedContext = appDelegate.persistentContainer.viewContext
        print("Managed Context:\(String(describing: managedContext))")
            
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "Tasks")
            
            do{
                print("Fetch request to Core Data. Sender: TasksTVC")
                
                tasks = Tasks(taskName: try managedContext!.fetch(fetchRequest), taskDescription: try managedContext!.fetch(fetchRequest), taskDate: try managedContext!.fetch(fetchRequest), taskState: try managedContext!.fetch(fetchRequest), taskIsActive: try managedContext!.fetch(fetchRequest))
            
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        print ("Fetch entry count \(tasks.taskName.count)")
        print ("Fetch sub-entry count \(tasks.taskDescription.count)")
        
        UserDefaults.standard.set(tasks.taskName.count, forKey: "taskCount")
        
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = .clear
        self.userNotificationCenter.delegate = self
        self.requestNotificationAuthorization()
        //self.sendNotification(title: "You have tasks", body: "Come back and check your tasks!", value: 1)
        //notificationButton.image = UIImage(named: "notificationActive")
//        self.view.setNeedsLayout()
//        self.view.layoutIfNeeded()
        
        //Core Data settings
        
        
        
        //TableView settings here
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        placeholderState()
        
        
        
        //self.view.bringSubviewToFront(tableView)
        
        //User Defaults for onboarding. For debug set to false, for production set to true
        UserDefaults.standard.set(true, forKey: "FirstLaunch")
        print("User default set!")
        
        // Do any additional setup after loading the view.
    }
    
    func saveNew(name:String, description:String, date: Date, state:Int, isActive:Bool = true){
        
        print ("Show \(String(describing: managedContext))")
            
        let entity = NSEntityDescription.entity(forEntityName: "Tasks",
                                                    in: managedContext!)
                                                   
        let tasks = NSManagedObject(entity: entity!,
                                           insertInto: managedContext)
            
            tasks.setValue(name, forKeyPath: "taskName")
            tasks.setValue(description, forKeyPath: "taskDescription")
            tasks.setValue(date, forKeyPath: "taskDate")
            tasks.setValue(state, forKeyPath: "taskState")
            tasks.setValue(isActive, forKey: "isActive")
            //4
            
            do {
                
                self.tasks.taskName.append(tasks)
                self.tasks.taskDescription.append(tasks)
                self.tasks.taskDate.append(tasks)
                self.tasks.taskState.append(tasks)
                self.tasks.taskIsActive.append(tasks)
            
                try managedContext!.save()
                print ("Data posted")
                //tableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            UserDefaults.standard.set(self.tasks.taskName.count, forKey: "taskCount")
            ongoingTaskCount += 1
            UserDefaults.standard.set(ongoingTaskCount, forKey: "ongoingTaskCount")
        }
        
        func save(name: String, description: String, date:Date, state:Int){
            
            
            tasks.taskName[currentIndex].setValue(name, forKey: "taskName")
            tasks.taskDescription[currentIndex].setValue(description, forKey: "taskDescription")
            tasks.taskDate[currentIndex].setValue(date, forKey: "taskDate")
            tasks.taskState[currentIndex].setValue(state, forKey: "taskState")
            
            do {
                try managedContext!.save()
                //try context!.save()
                //tableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                
            }
            UserDefaults.standard.set(self.tasks.taskName.count, forKey: "taskCount")
        }
    func saveTaskStateBool(isActive:Bool){
        tasks.taskIsActive[currentIndexBool].setValue(isActive, forKey: "isActive")
        do {
                       try managedContext!.save()
                       //try context!.save()
                       //tableView.reloadData()
                   } catch let error as NSError {
                       print("Could not save. \(error), \(error.userInfo)")
                       
                   }
    }
    
    func didUpdateTableView(sender: NewTaskVC) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    //Declare Tasks Table View properties here.
        var currentIndex:Int = 0
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tasks.taskName.count
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 120
           }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
                        let taskstate = tasks.taskState[indexPath.row]
                        let taskname = tasks.taskName[indexPath.row]
                        let description = tasks.taskDescription[indexPath.row]
                        let date = tasks.taskDate[indexPath.row]
                        let active = tasks.taskIsActive[indexPath.row]
                        let activebool = active.value(forKeyPath: "isActive") as? Bool
                        let insertedDate = date.value(forKeyPath: "taskDate") as? Date
                        
            
            
                        let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd/MM"
                        let dateLabel = dateFormatter.string(from: insertedDate!)
            
                        if taskstate.value(forKeyPath: "taskState") as? Int == 0  {
                           let cell = Bundle.main.loadNibNamed("ImportantTaskCell", owner: self, options: nil)?.first as! ImportantTaskCell
            
                           cell.titleTaskLabel.text = taskname.value(forKeyPath: "taskName") as? String
                           cell.dateTaskLabel.text = description.value(forKeyPath: "taskDescription") as? String
                           cell.deadlineTaskLabel.text = dateLabel
                           cell.taskCardView.layer.cornerRadius = 10
                            
                            if activebool == false {
                                cell.taskCardView.backgroundColor = .lightGray
                                cell.taskCardView.reloadInputViews()
                            }
                            
                           return cell
            
                       } else if taskstate.value(forKeyPath: "taskState") as? Int == 1 {
                           let cell = Bundle.main.loadNibNamed("ModerateTaskCell", owner: self, options: nil)?.first as! ModerateTaskCell
                           cell.titleTaskLabel.text = taskname.value(forKeyPath: "taskName") as? String
                           cell.dateTaskLabel.text = description.value(forKeyPath: "taskDescription") as? String
                           cell.deadlineTaskLabel.text = dateLabel
                           cell.taskCardView.layer.cornerRadius = 10
                            
                            if activebool == false {
                                cell.taskCardView.backgroundColor = .lightGray
                                cell.taskCardView.reloadInputViews()
                            }
                            
                           return cell
            
                        } else if taskstate.value(forKeyPath: "taskState") as? Int == 2 {
                          let cell = Bundle.main.loadNibNamed("LessImportantTaskCell", owner: self, options: nil)?.first as! LessImportantTaskCell
                          cell.titleTaskLabel.text = taskname.value(forKeyPath: "taskName") as? String
                          cell.dateTaskLabel.text = description.value(forKeyPath: "taskDescription") as? String
                          cell.deadlineTaskLabel.text = dateLabel
                          cell.taskCardView.layer.cornerRadius = 10
                            
                            if activebool == false {
                                cell.taskCardView.backgroundColor = .lightGray
                                cell.taskCardView.reloadInputViews()
                            }
                            
                          return cell
            
                       } else {
                           let cell = Bundle.main.loadNibNamed("AssistedTaskCell", owner: self, options: nil)?.first as! AssistedTaskCell
                           cell.titleTaskLabel.text = taskname.value(forKeyPath: "taskName") as? String
                           cell.dateTaskLabel.text = description.value(forKeyPath: "taskDescription") as? String
                           cell.deadlineTaskLabel.text = dateLabel
                           cell.taskCardView.layer.cornerRadius = 10
                            
                            if activebool == false {
                                cell.taskCardView.backgroundColor = .lightGray
                                cell.taskCardView.reloadInputViews()
                            }
                            
                           return cell
            
                       }
            
            
            
        }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView,
//      leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "editTaskSegue", sender: self)
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "Mark Complete") { (contextualAction, view, boolValue) in
            boolValue(true) // pass true if you want the handler to allow the action
            print("Leading Action style .normal")
            
            if self.tasks.taskIsActive[indexPath.row].value(forKey: "isActive") as? Bool != false {
            self.currentIndexBool = indexPath.row
            self.saveTaskStateBool(isActive: false)
            
            
            UserDefaults.standard.set(self.completedTaskCount, forKey: "completedTaskCount")
            UserDefaults.standard.set(self.ongoingTaskCount, forKey: "ongoingTaskCount")
            
            let alert = UIAlertController(title: "🥳 Hooray 🥳", message: "Congratulations, you have completed your task. Keep going!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true)
            }
            
            else {
                
                let alert = UIAlertController(title: "Error", message: "This task is already marked as complete. You can only mark it once.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true)
                
            }
        }
        contextItem.backgroundColor = .orange
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){// -> [UITableViewRowAction]?{

           //        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
           //                       tableView.isEditing = false
           //
           //           // your action
           //                   }
           //
           //        editAction.backgroundColor = UIColor.gray

           switch editingStyle {
            
           case .insert:
            
            print("insert")


           case .delete:
            
            let alert = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task? ", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) {
                
            [unowned self] action in
                
                if self.tasks.taskIsActive[indexPath.row].value(forKey: "isActive") as? Bool == false {
                    if self.completedTaskCount != 0 {
                        self.completedTaskCount -= 1
                        }
                        }
                        
                        else {
                    if self.ongoingTaskCount != 0 {
                            self.ongoingTaskCount -= 1
                        }
                        }
                        
                    
                        UserDefaults.standard.set(self.completedTaskCount, forKey: "completedTaskCount")
                        UserDefaults.standard.set(self.ongoingTaskCount, forKey: "ongoingTaskCount")
                    
                    

                print("entry \(self.tasks.taskName.count)")
                self.tasks.taskName.remove(at: indexPath.row)
                self.tasks.taskDescription.remove(at: indexPath.row)
                self.tasks.taskDate.remove(at: indexPath.row)
                self.tasks.taskState.remove(at: indexPath.row)
                self.tasks.taskIsActive.remove(at: indexPath.row)


                        //2
                        let fetchRequest =
                            NSFetchRequest<NSManagedObject>(entityName: "Tasks")

                        //3
                        do{
                            print("show")
                            self.tasks.taskName = try managedContext!.fetch(fetchRequest)
                            let resultData = self.tasks.taskName
                            //let pushData = resultData[indexPath.row]}

                            self.tasks.taskDescription = try managedContext!.fetch(fetchRequest)
                            let resultData2 = self.tasks.taskDescription
                            //let pushData2 = resultData2[indexPath.row]
                            self.tasks.taskDate = try managedContext!.fetch(fetchRequest)
                            let resultData3 = self.tasks.taskDate
                            self.tasks.taskState = try managedContext!.fetch(fetchRequest)
                            let resultData4 = self.tasks.taskState
                            self.tasks.taskIsActive = try managedContext!.fetch(fetchRequest)
                            let resultData5 = self.tasks.taskState
                                           

                            for _ in resultData {
                                managedContext?.delete(self.tasks.taskName[indexPath.row])
                            }

                            for _ in resultData2 {
                                managedContext?.delete(self.tasks.taskDescription[indexPath.row])
                            }

                            for _ in resultData3 {
                                managedContext?.delete(self.tasks.taskDate[indexPath.row])

                            }

                            for _ in resultData4 {
                                managedContext?.delete(self.tasks.taskState[indexPath.row])

                            }
                            
                            for _ in resultData5 {
                                managedContext?.delete(self.tasks.taskIsActive[indexPath.row])

                            }
                        }

                         catch let error as NSError {
                            print("Could not fetch. \(error), \(error.userInfo)")
                        }


                print("entry after \(self.tasks.taskName.count)")
                        do {
                            try managedContext!.save()
                            //try context!.save()
                            self.tasks.taskName.remove(at: indexPath.row)
                            self.tasks.taskDescription.remove(at: indexPath.row)
                            self.tasks.taskDate.remove(at: indexPath.row)
                            self.tasks.taskState.remove(at: indexPath.row)

                        }catch let error as NSError {
                            print("Could not save. \(error), \(error.userInfo)")
                        }
                        //self.tableView.deleteRows(at: [indexPath], with: .fade)
                UserDefaults.standard.set(self.tasks.taskName.count, forKey: "taskCount")
                UserDefaults.standard.set(self.ongoingTaskCount, forKey: "ongoingTaskCount")
                        tableView.reloadData()
            }
            
                let action1 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(action)
                alert.addAction(action1)
                               
                self.present(alert, animated: true)
            
                
//            if tasks.taskIsActive[indexPath.row].value(forKey: "isActive") as? Bool == false {
//                if completedTaskCount != 0 {
//                self.completedTaskCount -= 1
//                }
//                }
//
//                else {
//                if ongoingTaskCount != 0 {
//                    self.ongoingTaskCount -= 1
//                }
//                }
//
//
//                UserDefaults.standard.set(self.completedTaskCount, forKey: "completedTaskCount")
//                UserDefaults.standard.set(self.ongoingTaskCount, forKey: "ongoingTaskCount")
//
//
//
//            print("entry \(tasks.taskName.count)")
//            tasks.taskName.remove(at: indexPath.row)
//            tasks.taskDescription.remove(at: indexPath.row)
//            tasks.taskDate.remove(at: indexPath.row)
//            tasks.taskState.remove(at: indexPath.row)
//            tasks.taskIsActive.remove(at: indexPath.row)
//
//
//                //2
//                let fetchRequest =
//                    NSFetchRequest<NSManagedObject>(entityName: "Tasks")
//
//                //3
//                do{
//                    print("show")
//                    tasks.taskName = try managedContext!.fetch(fetchRequest)
//                    let resultData = tasks.taskName
//                    //let pushData = resultData[indexPath.row]}
//
//                    tasks.taskDescription = try managedContext!.fetch(fetchRequest)
//                    let resultData2 = tasks.taskDescription
//                    //let pushData2 = resultData2[indexPath.row]
//                    tasks.taskDate = try managedContext!.fetch(fetchRequest)
//                    let resultData3 = tasks.taskDate
//                    tasks.taskState = try managedContext!.fetch(fetchRequest)
//                    let resultData4 = tasks.taskState
//                    tasks.taskIsActive = try managedContext!.fetch(fetchRequest)
//                    let resultData5 = tasks.taskState
//
//
//                    for _ in resultData {
//                        managedContext?.delete(tasks.taskName[indexPath.row])
//                    }
//
//                    for _ in resultData2 {
//                        managedContext?.delete(tasks.taskDescription[indexPath.row])
//                    }
//
//                    for _ in resultData3 {
//                        managedContext?.delete(tasks.taskDate[indexPath.row])
//
//                    }
//
//                    for _ in resultData4 {
//                    managedContext?.delete(tasks.taskState[indexPath.row])
//
//                    }
//
//                    for _ in resultData5 {
//                    managedContext?.delete(tasks.taskIsActive[indexPath.row])
//
//                    }
//                }
//
//                 catch let error as NSError {
//                    print("Could not fetch. \(error), \(error.userInfo)")
//                }
//
//
//            print("entry after \(tasks.taskName.count)")
//                do {
//                    try managedContext!.save()
//                    //try context!.save()
//                    tasks.taskName.remove(at: indexPath.row)
//                    tasks.taskDescription.remove(at: indexPath.row)
//                    tasks.taskDate.remove(at: indexPath.row)
//                    tasks.taskState.remove(at: indexPath.row)
//
//                }catch let error as NSError {
//                    print("Could not save. \(error), \(error.userInfo)")
//                }
//                //self.tableView.deleteRows(at: [indexPath], with: .fade)
//                UserDefaults.standard.set(tasks.taskName.count, forKey: "taskCount")
//                UserDefaults.standard.set(ongoingTaskCount, forKey: "ongoingTaskCount")
//                tableView.reloadData()

            

                //print ("insert selected!")

           default: return

        }
    }
    
        
        func placeholderState () {
            if tasks.taskName.count != 0 {
                var labelFrame = placeholderText.frame
                labelFrame.size.height = 0
                placeholderText.frame = labelFrame
                placeholderImage.frame = labelFrame
                print ("No tasks. Drawing placeholder.")
            }
            else {
                print ("Tasks not empty. Removing placeholder.")
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destinationNewTask = segue.destination as? NewTaskVC {
            destinationNewTask.taskDelegate = self
               }
        if let destinationEditTask = segue.destination as? EditTaskVC {
            let taskname = tasks.taskName[currentIndex]
            let tasksub = tasks.taskDescription[currentIndex]
            let taskdate = tasks.taskDate[currentIndex]
            let taskstate = tasks.taskDescription[currentIndex]
            destinationEditTask.textFieldContent = (taskname.value(forKeyPath: "taskName") as? String)!
            destinationEditTask.textViewContent = (tasksub.value(forKeyPath: "taskDescription") as? String)!
            destinationEditTask.taskDetailInt = (taskstate.value(forKeyPath: "taskState") as? Int)!
            destinationEditTask.dueDate = (taskdate.value(forKeyPath: "taskDate") as? Date)!
            destinationEditTask.taskDelegate = self
        }
    }
    
    
    @IBAction func notificationButtonPressed(_ sender: UIBarButtonItem) {
        //self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(NotificationTVC(), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.completedTaskCount = 0
        self.ongoingTaskCount = 0
        
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Tasks")
        
        do{
            print("Fetch request to Core Data. Sender: TasksTVC, viewWillDisappear")
            
            self.tasks.taskIsActive = try managedContext!.fetch(fetchRequest)
        
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        for completedtask in self.tasks.taskIsActive {
            if completedtask.value(forKey: "isActive") as? Bool == false {
                self.completedTaskCount += 1
            }
            else {
                self.ongoingTaskCount += 1
            }
        }
        
        UserDefaults.standard.set(tasks.taskName.count, forKey: "taskCount")
        UserDefaults.standard.set(completedTaskCount, forKey: "completedTaskCount")
        UserDefaults.standard.set(ongoingTaskCount, forKey: "ongoingTaskCount")
    }
    
   


}







//let activeTasksCell = tableView.dequeueReusableCell(withIdentifier: "activeTasksCell", for: indexPath)
//let taskname = tasks.taskName[indexPath.row]
//let tasksub = tasks.taskDescription[indexPath.row]
//activeTasksCell.textLabel?.text = taskname.value(forKeyPath: "taskName") as? String
//activeTasksCell.detailTextLabel?.text = tasksub.value(forKeyPath: "taskDescription") as? String
//return activeTasksCell
