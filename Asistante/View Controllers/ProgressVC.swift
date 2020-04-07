//
//  SecondViewController.swift
//  Asistante
//
//  Created by Domenico Allegra on 30/03/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class ProgressVC: UIViewController {
    
    
    
    //Declare UI components here
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var completedTasksLabel: UILabel!
    @IBOutlet weak var remainingTasksLabel: UILabel!
    @IBOutlet weak var delayedTasksLabel: UILabel!
    
    @IBOutlet weak var notificationButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let progressPageUsername = UserDefaults.standard.string(forKey: "Username")
            else {
                return
            }
        
        userNameLabel.text = "Hello, \(progressPageUsername)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func notificationButtonPressed(_ sender: UIButton) {
    }
    

}

