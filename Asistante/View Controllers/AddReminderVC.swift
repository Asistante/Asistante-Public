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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonPressed(_ sender: Any) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        let labelReminder = dateFormatter.string(from: self.reminderDatePicker.date)
        print (labelReminder)
        dateshown = labelReminder
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
