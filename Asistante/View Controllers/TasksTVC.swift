//
//  FirstViewController.swift
//  Asistante
//
//  Created by Domenico Allegra on 30/03/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit
import CoreData

class TasksTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
        
    //Core Data context.
    var context:NSManagedObjectContext?
    
 
    struct Tasks {
        var taskName:[NSManagedObject] = []
        var taskDescription:[NSManagedObject] = []
        var taskDate:[NSManagedObject] = []
        var taskState:[NSManagedObject] = []
    }
    
    var tasks:Tasks = Tasks()
    //Declare cell types for table view.
    
    
//    enum CellType{
//        case activeTasksCell
//        case inactiveTasksCell
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hidesBottomBarWhenPushed = false
//        self.view.setNeedsLayout()
//        self.view.layoutIfNeeded()
        
        
        //Core Data settings
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
        
            context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "Tasks")
            
            do{
                print("Fetch request to Core Data. Sender: TasksTVC")
                
                tasks = Tasks(taskName: try context!.fetch(fetchRequest), taskDescription: try context!.fetch(fetchRequest), taskDate: try context!.fetch(fetchRequest), taskState: try context!.fetch(fetchRequest))
            
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        
        //TableView settings here
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        placeholderState()
        
        
        
        //self.view.bringSubviewToFront(tableView)
        
        //User Defaults for onboarding. For debug set to false, for production set to true
        UserDefaults.standard.set(false, forKey: "FirstLaunch")
        print("User default set!")
        UserDefaults.standard.set("Asep", forKey: "Username")
        print("Username set!")
        // Do any additional setup after loading the view.
    }
    
    
    //Declare Tasks Table View properties here.
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tasks.taskName.count
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //Active tasks cell
            let activeTasksCell = tableView.dequeueReusableCell(withIdentifier: "activeTasksCell", for: indexPath)
            return activeTasksCell
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
       // self.hidesBottomBarWhenPushed = true
    }
    
    @IBAction func notificationButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "notificationSegue", sender: self)
    }
    
    


}

