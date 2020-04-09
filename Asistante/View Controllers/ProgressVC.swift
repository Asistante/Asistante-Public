//
//  SecondViewController.swift
//  Asistante
//
//  Created by Domenico Allegra on 30/03/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

protocol ProgressVCDelegate: class {
    func removeParentButton()
}

class ProgressVC: UIViewController {
    
     //text properties
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
       
    @IBOutlet weak var completedNow: UILabel!
    @IBOutlet weak var completedAll: UILabel!
       
    @IBOutlet weak var onGoingNow: UILabel!
    @IBOutlet weak var onGoingAll: UILabel!
       
    @IBOutlet weak var failedNow: UILabel!
    @IBOutlet weak var failedAll: UILabel!
       
    @IBOutlet weak var progressLabel: UILabel!
       
       
       //Declare UI components here
    @IBOutlet weak var progressBarFull: UIView!
    @IBOutlet weak var progressBarProcess: UIView!
    @IBOutlet weak var completeTaskView: UIView!
    @IBOutlet weak var onGoingTaskView: UIView!
    @IBOutlet weak var failedTaskView: UIView!
       
       // all the views group
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressSummaryView: UIView!
    
    @IBOutlet weak var notificationButton: UIBarButtonItem!
    
//    var addButton: UIButton!
    
    weak var delegate: ProgressVCDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setupMiddleButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeTaskView.layer.cornerRadius = 20
        onGoingTaskView.layer.cornerRadius = 20
        failedTaskView.layer.cornerRadius = 20
        
        progressView.layer.cornerRadius = 20
        progressView.layer.shadowColor = UIColor.black.cgColor
        progressView.layer.shadowOpacity = 0.2
        progressView.layer.shadowOffset = CGSize(width: 15,height: 15)
        progressView.layer.shadowRadius = 10
        
        progressSummaryView.layer.cornerRadius = 25
        
        progressBarFull.layer.cornerRadius = 15
        progressBarFull.layer.shadowColor = UIColor.black.cgColor
        progressBarFull.layer.shadowOpacity = 0.2
        progressBarFull.layer.shadowOffset = CGSize(width: 8,height: 8)
        progressBarFull.layer.shadowRadius = 10
        
        progressBarProcess.layer.cornerRadius = 15
        
        completeTaskView.layer.cornerRadius = 15
        completeTaskView.layer.shadowColor = UIColor.black.cgColor
        completeTaskView.layer.shadowOpacity = 0.2
        completeTaskView.layer.shadowOffset = CGSize(width: 5,height: 5)
        completeTaskView.layer.shadowRadius = 5
        
        onGoingTaskView.layer.cornerRadius = 15
        onGoingTaskView.layer.shadowColor = UIColor.black.cgColor
        onGoingTaskView.layer.shadowOpacity = 0.2
        onGoingTaskView.layer.shadowOffset = CGSize(width: 5,height: 5)
        onGoingTaskView.layer.shadowRadius = 5
        
        failedTaskView.layer.cornerRadius = 15
        failedTaskView.layer.shadowColor = UIColor.black.cgColor
        failedTaskView.layer.shadowOpacity = 0.2
        failedTaskView.layer.shadowOffset = CGSize(width: 5,height: 5)
        failedTaskView.layer.shadowRadius = 5
        
        guard let progressPageUsername = UserDefaults.standard.string(forKey: "Username")
            else {
                return
            }
        
        userNameLabel.text = "Hello, \(progressPageUsername)"
        // Do any additional setup after loading the view.
        //setupMiddleButton()
    }
    
//    func setupMiddleButton() {
//        addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
//
//        addButton.frame.origin.y = view.bounds.height - addButton.frame.height-40
//        addButton.frame.origin.x = view.bounds.width/2 - addButton.frame.size.width/2
//        //addButton.frame = addButtonFrame
//
//        addButton.backgroundColor = UIColor.white
//        addButton.layer.cornerRadius = addButton.frame.height/2
//
//        addButton.setImage(UIImage(named: "addTaskButton"), for: .normal)
//        addButton.addTarget(self, action: #selector(addButtonAction(sender:)), for: .touchUpInside)
//
//        self.view.addSubview(addButton)
//        addButton.bringSubviewToFront(view)
//
//    }
    
    @objc private func addButtonAction(sender: UIButton) {
         //selectedIndex = 2
         performSegue(withIdentifier: "addTaskSegue", sender: self)
     }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //addButton.removeFromSuperview()
    }
    
    @IBAction func notificationButtonPressed(_ sender: UIButton) {
        let notifVC = NotificationTVC()
        //self.delegate?.removeParentButton()
        self.navigationController?.pushViewController(notifVC, animated: true)
    }
    

}

