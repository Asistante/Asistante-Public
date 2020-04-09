//
//  TabBarController.swift
//  Asistante
//
//  Created by Domenico Allegra on 04/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "FirstLaunch")
        //setupMiddleButton()
        setDelegate()
        // Do any additional setup after loading the view.
    }
    
    func setDelegate() {
        let pvc = ProgressVC()
        pvc.delegate = self
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

        view.addSubview(addButton)
        
    }
    
    func removeAllSubview() {
        for viewItem in view.subviews {
            viewItem.removeFromSuperview()
        }
        addButton.removeFromSuperview()
    }
    
    @objc private func addButtonAction(sender: UIButton) {
        //selectedIndex = 2
        performSegue(withIdentifier: "addTaskSegue", sender: self)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
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

extension TabBarController: ProgressVCDelegate {
    func removeParentButton() {
        self.removeAllSubview()
    }
    
    
}
