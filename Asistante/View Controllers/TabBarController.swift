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
        
       setupMiddleButton()

        // Do any additional setup after loading the view.
    }
    
    func setupMiddleButton() {
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))

        var addButtonFrame = addButton.frame
        addButtonFrame.origin.y = view.bounds.height - addButtonFrame.height-40
        addButtonFrame.origin.x = view.bounds.width/2 - addButtonFrame.size.width/2
        addButton.frame = addButtonFrame

        addButton.backgroundColor = UIColor.white
        addButton.layer.cornerRadius = addButtonFrame.height/2
        view.addSubview(addButton)

        addButton.setImage(UIImage(named: "addTaskButton"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonAction(sender:)), for: .touchUpInside)

        view.layoutIfNeeded()
    }
    
    @objc private func addButtonAction(sender: UIButton) {
        //selectedIndex = 2
        performSegue(withIdentifier: "addTaskSegue", sender: self)
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
