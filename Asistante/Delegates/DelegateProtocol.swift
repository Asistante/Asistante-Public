//
//  DelegateProtocol.swift
//  Asistante
//
//  Created by Domenico Allegra on 10/04/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import Foundation

protocol TasksTVCDelegate {
    func didSaved(name: String, description: String, date: Date, state: Int)
    func didSaveNew(name: String, description: String, date: Date, state: Int)
}

protocol NewTaskDelegate {
    func passDate(date:Date)
    func passReminder(date:String)
    func passPriority(priority:String)
    
}
