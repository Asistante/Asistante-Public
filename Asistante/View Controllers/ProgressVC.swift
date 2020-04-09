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
    
    //Declare UI components here
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var completedTasksLabel: UILabel!
    @IBOutlet weak var remainingTasksLabel: UILabel!
    @IBOutlet weak var delayedTasksLabel: UILabel!
    
    @IBOutlet weak var notificationButton: UIBarButtonItem!
    
    var addButton: UIButton!
    
    weak var delegate: ProgressVCDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMiddleButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let progressPageUsername = UserDefaults.standard.string(forKey: "Username")
            else {
                return
            }
        
        userNameLabel.text = "Hello, \(progressPageUsername)"
        // Do any additional setup after loading the view.
        //setupMiddleButton()
    }
    
    func setupMiddleButton() {
        addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))

        addButton.frame.origin.y = view.bounds.height - addButton.frame.height-40
        addButton.frame.origin.x = view.bounds.width/2 - addButton.frame.size.width/2
        //addButton.frame = addButtonFrame
        
        addButton.backgroundColor = UIColor.white
        addButton.layer.cornerRadius = addButton.frame.height/2

        addButton.setImage(UIImage(named: "addTaskButton"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonAction(sender:)), for: .touchUpInside)

        self.view.addSubview(addButton)
        addButton.bringSubviewToFront(view)
        
    }
    
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

