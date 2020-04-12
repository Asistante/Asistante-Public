//
//  AddReminderVC.swift
//  Asistante
//
//  Created by Domenico Allegra on 09/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit



class AddReminderVC: UIViewController, UIPickerViewDelegate {
    
    
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    
    var newTaskDelegate: NewTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        newTaskDelegate?.passReminder(date: self.reminderDatePicker.date)
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