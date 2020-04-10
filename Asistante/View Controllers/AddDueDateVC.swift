//
//  AddDueDateVC.swift
//  Asistante
//
//  Created by Domenico Allegra on 10/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class AddDueDateVC: UIViewController {

    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var newTaskDelegate: NewTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        newTaskDelegate?.passDate(date: self.dueDatePicker.date)
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
