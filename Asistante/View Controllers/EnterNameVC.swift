//
//  EnterNameVC.swift
//  Asistante
//
//  Created by Domenico Allegra on 07/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class EnterNameVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = 20
        self.nameTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func goToMain(){
        
        guard let enteredName = nameTextField.text else {return}
        UserDefaults.standard.set(enteredName, forKey: "Username")
        print("Username set!")
        performSegue(withIdentifier: "toMainSegue", sender: self)
        
//        self.navigationController?.pushViewController(TabBarController(), animated: true)
    }

    @IBAction func goButtonPressed(_ sender: Any) {
        goToMain()
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
