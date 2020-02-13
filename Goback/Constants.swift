//
//  Constants.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/9/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import Foundation
import UIKit

var todoList:[String]?
var notesList:[String]?

var impact = UIImpactFeedbackGenerator()

func saveData(todoList:[String]) {
    UserDefaults.standard.set(todoList, forKey: "todoList")
    
}

func fetchData(key: String) -> [String]? {
    if let todo = UserDefaults.standard.array(forKey: key) as? [String] {
        return todo
    }
    else {
        return nil
    }
}

func doHaptic() {
    if (UserDefaults.standard.bool(forKey: "enable_haptics")) {
        impact.impactOccurred()
    }
}
