//
//  TabBarController.swift
//  Asistante
//
//  Created by Domenico Allegra on 04/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "FirstLaunch")
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
//        let taskController = self.tabBarController?.viewControllers?[1] as? NewTaskVC
//        taskController?.delegate = self
        super.viewWillDisappear(animated)
        //addButton.removeFromSuperview()
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

