//
//  EditReminderVC.swift
//  Asistante
//
//  Created by Domenico Allegra on 12/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class EditReminderVC: UIViewController {

    
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    var editTaskDelegate: EditTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        editTaskDelegate?.passReminder(date: self.reminderDatePicker.date)
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
