//
//  DelegateProtocol.swift
//  Asistante
//
//  Created by Domenico Allegra on 10/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import Foundation
import UIKit

protocol TasksTVCDelegate {
    func didSaved(name: String, description: String, date: Date, state: Int)
    func didSaveNew(name: String, description: String, date: Date, state: Int)
    func didUpdateTableView(sender: NewTaskVC)
}

protocol NewTaskDelegate {
    func passDate(date:Date)
    func passReminder(date:Date)
    func passPriority(priority:String)
    
}

protocol EditTaskDelegate {
    func passDate(date:Date)
    func passReminder(date:Date)
    func passPriority(priority:String)
    
}


var vSpinner : UIView?
 
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

