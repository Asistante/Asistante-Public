//
//  TaskPriorityVC.swift
//  Asistante
//
//  Created by Domenico Allegra on 08/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class TaskPriorityVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var tasksPicker: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksPicker = ["Important","Moderate","Low", "Assisted"]
        tabBarController?.tabBar.isHidden = true
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskPriorityCell", for: indexPath)
        cell.textLabel?.text = tasksPicker[indexPath.row]
        if indexPath.row == 0 {
            cell.imageView?.tintColor = #colorLiteral(red: 0.8196078431, green: 0.3098039216, blue: 0.2509803922, alpha: 1)
        }
        else if indexPath.row == 1 {
            cell.imageView?.tintColor = #colorLiteral(red: 0.9921568627, green: 0.7450980392, blue: 0.08235294118, alpha: 1)
        }
        else if indexPath.row == 2 {
            cell.imageView?.tintColor = #colorLiteral(red: 0.1294117647, green: 0.7254901961, blue: 0.8745098039, alpha: 1)
        }
        else {
            cell.imageView?.tintColor = #colorLiteral(red: 0.7411764706, green: 0.8392156863, blue: 0.1882352941, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let sentState = tasksPicker[indexPath.row]
        taskType = tasksPicker[indexPath.row]
        self.navigationController?.popViewController(animated: true)
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
